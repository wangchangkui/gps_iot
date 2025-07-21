package cn.admcc.util.gis;


import cn.admcc.util.JacksonUtils;
import cn.hutool.core.util.ArrayUtil;
import com.fasterxml.jackson.core.type.TypeReference;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.tuple.Triple;
import org.geotools.api.data.FileDataStore;
import org.geotools.api.data.FileDataStoreFinder;
import org.geotools.api.feature.GeometryAttribute;
import org.geotools.api.feature.simple.SimpleFeature;
import org.geotools.api.feature.simple.SimpleFeatureType;
import org.geotools.api.filter.FilterFactory;
import org.geotools.api.referencing.FactoryException;
import org.geotools.api.referencing.crs.CoordinateReferenceSystem;
import org.geotools.api.referencing.cs.CoordinateSystem;
import org.geotools.api.referencing.cs.CoordinateSystemAxis;
import org.geotools.api.referencing.operation.MathTransform;
import org.geotools.api.referencing.operation.TransformException;
import org.geotools.coverage.grid.GridCoverage2D;
import org.geotools.coverage.grid.io.AbstractGridFormat;
import org.geotools.coverage.grid.io.GridCoverage2DReader;
import org.geotools.coverage.grid.io.GridFormatFinder;
import org.geotools.coverage.grid.io.UnknownFormat;
import org.geotools.data.collection.ListFeatureCollection;
import org.geotools.data.geojson.GeoJSONReader;
import org.geotools.data.geojson.GeoJSONWriter;
import org.geotools.data.simple.SimpleFeatureCollection;
import org.geotools.data.simple.SimpleFeatureIterator;
import org.geotools.feature.DefaultFeatureCollection;
import org.geotools.feature.simple.SimpleFeatureBuilder;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.filter.FilterFactoryImpl;
import org.geotools.geometry.jts.JTS;
import org.geotools.geometry.jts.JTSFactoryFinder;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.referencing.CRS;
import org.geotools.referencing.crs.DefaultGeographicCRS;
import org.geotools.referencing.crs.DefaultProjectedCRS;
import org.geotools.util.factory.Hints;
import org.locationtech.jts.algorithm.distance.DistanceToPoint;
import org.locationtech.jts.algorithm.distance.PointPairDistance;
import org.locationtech.jts.geom.*;
import org.locationtech.jts.geom.util.GeometryFixer;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;
import org.locationtech.jts.linearref.LengthLocationMap;
import org.locationtech.jts.operation.union.UnaryUnionOp;

import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.util.function.ThrowingFunction;

import javax.imageio.stream.FileImageInputStream;
import java.awt.image.Raster;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import java.util.stream.Stream;


import static org.geotools.util.factory.Hints.FORCE_LONGITUDE_FIRST_AXIS_ORDER;

/**
 * @author LNX
 * @date 2021/8/19 9:01
 */
@Slf4j
public abstract class GeoToolsUtils {

    private static final GeometryFactory GEOMETRY_FACTORY = JTSFactoryFinder.getGeometryFactory(new Hints(FORCE_LONGITUDE_FIRST_AXIS_ORDER, true));

    public static final FilterFactory FILTER_FACTORY = new FilterFactoryImpl(new Hints(FORCE_LONGITUDE_FIRST_AXIS_ORDER, true));

    // 4326
    public static CoordinateReferenceSystem EPSG_4326;

    // Pseudo-Mercator(墨卡托投影) 3857
    public static CoordinateReferenceSystem EPSG_3857;

    public static CoordinateReferenceSystem EPSG_4544;

    //CGCS 2000 108
    public static CoordinateReferenceSystem EPSG_4545;

    static {
        try {
            EPSG_4326 = CRS.decode("EPSG:4326", true);
            EPSG_3857 = CRS.decode("EPSG:3857", true);
            EPSG_4544 = CRS.decode("EPSG:4544", true);
            EPSG_4545 = CRS.decode("EPSG:4545", true);
        } catch (FactoryException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 解码
     *
     * @param epsg epsg
     * @return {@link CoordinateReferenceSystem}
     */
    public static CoordinateReferenceSystem decode(String epsg) {
        try {
            return CRS.decode(epsg, true);
        } catch (FactoryException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Geometry转featureCollection
     *
     * @param geometryList geom集合
     */
    public static SimpleFeatureCollection geomToFeatureCollection(List<GeomVO> geometryList, String name, CoordinateReferenceSystem crs) {
        Assert.hasLength(name, "名称不能为空！");
        Assert.notEmpty(geometryList, "空间对象不能为空！");
        //创建要素模板
        SimpleFeatureTypeBuilder typeBuilder = new SimpleFeatureTypeBuilder();
        //设置坐标系
        typeBuilder.setCRS(crs);
        typeBuilder.setName(name);
        typeBuilder.setDefaultGeometry("geometry");
        typeBuilder.add("geometry", Geometry.class);
        geometryList.stream()
            .flatMap(geomVO -> geomVO.getProperties().stream().distinct())
            .forEach(o -> typeBuilder.add(o.getName(), Optional.ofNullable(o.getV()).orElse(Object.class).getClass()));
        SimpleFeatureType type = typeBuilder.buildFeatureType();
        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(type);
        List<SimpleFeature> features = IntStream.range(0, geometryList.size())
            .mapToObj(index -> {
                SimpleFeature feature = fb.buildFeature(String.valueOf(index));
                GeomVO geomVO = geometryList.get(index);
                Geometry geometry = geomVO.getGeometry();
                feature.setDefaultGeometry(geometry);
                geomVO.getProperties().forEach(o -> feature.setAttribute(o.getName(), o.getV()));
                return feature;
            })
            .collect(Collectors.toList());
        return new ListFeatureCollection(type, features);
    }


    public static Polygon createPolygon(Envelope envelope2D) {
        // Create coordinates for the polygon
        Coordinate[] coordinates = new Coordinate[]{
            new Coordinate(envelope2D.getMinX(), envelope2D.getMinY()),
            new Coordinate(envelope2D.getMaxX(), envelope2D.getMinY()),
            new Coordinate(envelope2D.getMaxX(), envelope2D.getMaxY()),
            new Coordinate(envelope2D.getMinX(), envelope2D.getMaxY()),
            new Coordinate(envelope2D.getMinX(), envelope2D.getMinY()) // Closing the polygon
        };
        LinearRing linearRing = GEOMETRY_FACTORY.createLinearRing(coordinates);
        return GEOMETRY_FACTORY.createPolygon(linearRing, null);
    }

    /**
     * Geometry转featureCollection
     *
     * @param geometryList geom集合
     */
    public static SimpleFeatureCollection geometries2FeatureCollection(List<? extends Geometry> geometryList, String name, CoordinateReferenceSystem crs) {
        Assert.hasLength(name, "名称不能为空！");
        Assert.notEmpty(geometryList, "空间对象不能为空！");
        //创建要素模板
        SimpleFeatureTypeBuilder typeBuilder = new SimpleFeatureTypeBuilder();
        //设置坐标系
        typeBuilder.setCRS(crs);
        typeBuilder.setName(name);
        typeBuilder.setDefaultGeometry("geometry");
        typeBuilder.add("geometry", Geometry.class);
        SimpleFeatureType type = typeBuilder.buildFeatureType();
        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(type);
        List<SimpleFeature> features = IntStream.range(0, geometryList.size())
            .mapToObj(index -> {
                SimpleFeature feature = fb.buildFeature(String.valueOf(index));
                Geometry geometry = geometryList.get(index);
                feature.setDefaultGeometry(geometry);
                return feature;
            })
            .collect(Collectors.toList());
        return new ListFeatureCollection(type, features);
    }

    /**
     * Geometry转featureCollection (批处理版本)
     * 适用于中等规模数据，通过批处理减少内存压力
     *
     * @param geometryList geom集合
     * @param name 名称
     * @param crs 坐标系
     * @param batchSize 批处理大小，建议1000-5000
     * @return SimpleFeatureCollection
     */
    public static SimpleFeatureCollection geomToFeatureCollectionBatch(List<GeomVO> geometryList, String name,
                                                                       CoordinateReferenceSystem crs, int batchSize) {
        Assert.hasLength(name, "名称不能为空！");
        Assert.notEmpty(geometryList, "空间对象不能为空！");

        if (batchSize <= 0) {
            batchSize = 1000; // 默认批处理大小
        }

        // 创建要素模板
        SimpleFeatureTypeBuilder typeBuilder = new SimpleFeatureTypeBuilder();
        typeBuilder.setCRS(crs);
        typeBuilder.setName(name);
        typeBuilder.setDefaultGeometry("geometry");
        typeBuilder.add("geometry", Geometry.class);

        // 收集所有唯一的属性名称和类型
        Set<String> processedProperties = new HashSet<>();
        for (GeomVO geomVO : geometryList) {
            for (GeomVO.Property property : geomVO.getProperties()) {
                if (processedProperties.add(property.getName())) {
                    Class<?> valueClass = property.getV() != null ?
                        property.getV().getClass() : String.class; // 默认使用String类型
                    typeBuilder.add(property.getName(), valueClass);
                }
            }
        }

        SimpleFeatureType type = typeBuilder.buildFeatureType();
        SimpleFeatureBuilder fb = new SimpleFeatureBuilder(type);

        // 使用批处理来减少内存压力
        List<SimpleFeature> allFeatures = new ArrayList<>();

        for (int i = 0; i < geometryList.size(); i += batchSize) {
            int endIndex = Math.min(i + batchSize, geometryList.size());
            List<GeomVO> batch = geometryList.subList(i, endIndex);

            List<SimpleFeature> batchFeatures = batch.stream()
                .map(geomVO -> {
                    try {
                        SimpleFeature feature = fb.buildFeature(String.valueOf(allFeatures.size() + batch.indexOf(geomVO)));
                        feature.setDefaultGeometry(geomVO.getGeometry());

                        geomVO.getProperties().forEach(property -> {
                            try {
                                feature.setAttribute(property.getName(), property.getV());
                            } catch (Exception e) {
                                System.err.println("Failed to set attribute: " + property.getName() + ", error: " + e.getMessage());
                            }
                        });

                        return feature;
                    } catch (Exception e) {
                        throw new RuntimeException("Error creating feature", e);
                    }
                })
                .toList();

            allFeatures.addAll(batchFeatures);

            // 手动触发垃圾回收（可选）
            if (i % (batchSize * 10) == 0) {
                System.gc();
            }
        }

        return new ListFeatureCollection(type, allFeatures);
    }

    /**
     * SimpleFeatureCollection到几何图形列表
     *
     * @param sfc SimpleFeatureCollection
     * @return {@link List}<{@link Geometry}>
     */
    public static List<Geometry> fcToGeometryList(SimpleFeatureCollection sfc) {
        List<Geometry> geometries = new LinkedList<>();
        try (SimpleFeatureIterator features = sfc.features()) {
            while (features.hasNext()) {
                SimpleFeature next = features.next();
                Geometry defaultGeometry = (Geometry) next.getDefaultGeometry();
                if (defaultGeometry == null) {
                    continue;
                }
                geometries.add(topologyFix(defaultGeometry));
            }
        }
        return geometries;
    }

    /**
     * @param geometry
     * @param c
     * @return
     */
    public static Coordinate getDistance(Geometry geometry, Coordinate c) {
        PointPairDistance ppd = new PointPairDistance();
        DistanceToPoint.computeDistance(geometry, c, ppd);
        List<Coordinate> coordinates = new ArrayList<>(Arrays.asList(ppd.getCoordinates()));
        coordinates.remove(c);
        if (!CollectionUtils.isEmpty(coordinates) && coordinates.size() == 1) {
            return coordinates.get(0);
        }
        return new Coordinate();
    }

    public static Point creatPoint(Coordinate coordinate) {
        return GEOMETRY_FACTORY.createPoint(coordinate);
    }

    public static Point creatPoint(Double x, Double y) {
        return GEOMETRY_FACTORY.createPoint(new Coordinate(x, y));
    }

    public static Point creatPoint(Double x, Double y, Double z) {
        return GEOMETRY_FACTORY.createPoint(new Coordinate(x, y, z));
    }

    public static LineString creatLineString(Coordinate[] coordinates) {
        return GEOMETRY_FACTORY.createLineString(coordinates);
    }

    public static MultiPolygon createMultiPolygon(Polygon[] polygons) {
        return GEOMETRY_FACTORY.createMultiPolygon(polygons);
    }

    public static Geometry toGeometry(Double x, Double y) {
        return GEOMETRY_FACTORY.toGeometry(new Envelope(new Coordinate(x, y)));
    }

    /**
     * 合并Geometry 效率高，推荐
     *
     * @param geometries Geometry结合
     * @return 合并后的结果
     */
    public static Geometry union(Collection<? extends Geometry> geometries) {
        return UnaryUnionOp.union(geometries);
    }

    /**
     * Geometry转geojson
     *
     * @param geometry Geometry对象
     */
    public static String geometryToGeoJSON(Geometry geometry) {
        return GeoJSONWriter.toGeoJSON(geometry);
    }

    /**
     * Geometry转geojson对象
     *
     * @param geometry Geometry对象
     */
    public static Map<String, Object> geometryToMap(Geometry geometry) {
        String geoJSON = geometryToGeoJSON(geometry);
        return JacksonUtils.parseObject(geoJSON, new TypeReference<Map<String, Object>>() {
        });
    }

    /**
     * geojson转Geometry
     *
     * @param geoJson geojson字符串
     */
    public static Geometry geoJsonToGeometry(String geoJson) {
        if (!StringUtils.hasText(geoJson)) {
            return null;
        }
        return GeoJSONReader.parseGeometry(geoJson);
    }

    public static Geometry wktToGeometry(String wkt) {
        WKTReader reader = new WKTReader();
        try {
            return reader.read(wkt);
        } catch (ParseException e) {
            log.error("格式化wkt异常，返回一个Point！message: {}", e.getMessage());
            return GEOMETRY_FACTORY.createEmpty(0);
        }
    }


    /**
     * 更具坐标系判断得到米还是度
     *
     * @param mater 米
     * @return
     */
    public static Double getDegree(Double mater, CoordinateReferenceSystem crs) {
        //地理坐标系
        if (crs instanceof DefaultGeographicCRS) {
            return mater / (2 * Math.PI * 6371004) * 360;
        }
        //投影坐标系
        if (crs instanceof DefaultProjectedCRS) {
            return mater;
        }
        throw new IllegalArgumentException("未知的坐标系！");
    }

    /**
     * 计算给定几何对象的面积
     * 如果源坐标参考系统是地理坐标系，则先将几何对象转换为EPSG:3857坐标系，再计算面积
     *
     * @param geometry 几何对象，用于计算面积
     * @param sourceCRS 源坐标参考系统，用于判断是否需要进行坐标转换
     * @return 几何对象的面积
     */
    public static Double getArea(Geometry geometry, CoordinateReferenceSystem sourceCRS) {
        //地理坐标系
        if (sourceCRS instanceof DefaultGeographicCRS) {
            return GeoToolsUtils.geometryTransform(geometry, sourceCRS, EPSG_3857).getArea();
        }
        return geometry.getArea();
    }


    /**
     * geojson 转featureCollection
     *
     * @param is 输入流
     */
    public static SimpleFeatureCollection geoJsonToCollection(InputStream is) throws IOException {
        try (GeoJSONReader geoJSONReader = new GeoJSONReader(is)) {
            return geoJSONReader.getFeatures();
        }
    }

    /**
     * geojson 转featureCollection
     *
     * @param geoJson 字符串
     */
    public static SimpleFeatureCollection geoJsonToCollection(String geoJson) throws IOException {
        try (GeoJSONReader geoJSONReader = new GeoJSONReader(geoJson)) {
            return geoJSONReader.getFeatures();
        }
    }

    /**
     * geom重投影
     *
     * @param geometry  待重投影的geometry
     * @param sourceCRS 源CRS
     * @param targetCRS 目标CRS
     */
    public static Geometry geometryTransform(Geometry geometry, CoordinateReferenceSystem sourceCRS,
                                             CoordinateReferenceSystem targetCRS) {
        try {
            MathTransform transform = CRS.findMathTransform(sourceCRS, targetCRS, true);
            return JTS.transform(geometry, transform);
        } catch (FactoryException | TransformException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 构建ShapefileDataStore
     *
     * @param file shpfile
     * @return FileDataStore 接口
     */
    public static FileDataStore buildFileDataStore(File file) throws IOException {
        return FileDataStoreFinder.getDataStore(file);
    }

    /**
     * 是有效坐标
     *
     * @param x   x
     * @param y   y
     * @param crs crs
     */
    public static void isValidCoordinate(double x, double y, CoordinateReferenceSystem crs) {
        Assert.notNull(crs, "crs 不能为空");
        CoordinateSystem coordinateSystem = crs.getCoordinateSystem();
        CoordinateSystemAxis axis = coordinateSystem.getAxis(0);
        CoordinateSystemAxis axis1 = coordinateSystem.getAxis(1);
        double maxX = axis.getMaximumValue();
        double maxY = axis1.getMaximumValue();
        double minX = axis.getMinimumValue();
        double minY = axis1.getMinimumValue();

        String code = crs.getName().getCode();
        if (x > maxX || x < minX) {
            String range = String.format("输入的的经度%s 不在参考坐标系：%s 经度 [%s,%s] 范围内，请重新选择你的参考坐标系！", x, code, minX, maxX);
            throw new IllegalArgumentException(range);
        }

        if (y > maxY || y < minY) {
            String range = String.format("输入的纬度%s 不在参考坐标系：%s 纬度 [%s,%s] 范围内，请重新选择你的参考坐标系！", y, code, minY, maxY);
            throw new IllegalArgumentException(range);
        }
    }



    /**
     * 从TIFF图像文件中提取像素值并应用函数转换。
     * 此方法专门处理TIFF格式的栅格数据文件，通过读取文件内容，解析每个像素的值，
     * 并对这些值应用提供的函数后再存储在一个集合中返回。这在需要对图像数据进行分析或处理的场景中非常有用，比如
     * 地理信息系统（GIS）中对遥感图像的处理。
     *
     * @param gridPath 栅格图像的文件路径，必须是存在的TIFF文件路径。
     * @param function 一个函数，用于转换像素值列表到单个双精度浮点数。这个函数定义了对每个像素的值进行的操作。
     * @return 包含所有应用了转换函数的像素值的双精度浮点数集合。
     * @throws IOException 如果读取文件时发生错误。
     */
    public static List<Double> tiffPixelValues(Path gridPath, Function<List<Double>, Double> function) throws IOException {
        File gridFile = gridPath.toFile();
        // 确保栅格文件存在
        Assert.isTrue(gridFile.exists(), "栅格文件不存在！");

        // https://docs.geotools.org/stable/userguide/library/coverage/arcgrid.html
        // asc支持
        AbstractGridFormat format;
        try (FileImageInputStream is = new FileImageInputStream(gridFile)) {
            format = GridFormatFinder.findFormat(is);
            // 如果格式未知，抛出异常
            if (format instanceof UnknownFormat) {
                String name = gridFile.getName();
                throw new RuntimeException("无法确定这个 " + name + " 文件是不是栅格数据类型，请确认你的栅格数据是否正确，或者将数据交给管理员处理！");
            }
        }

        GridCoverage2DReader reader = null;
        GridCoverage2D coverage = null;

        try (InputStream in = new FileInputStream(gridFile)) {
            // 创建读取器，用于读取栅格数据
            reader = format.getReader(in);
            // 读取栅格数据
            // 读取栅格数据为GridCoverage2D对象
            coverage = reader.read(null);
            // 获取渲染的图像
            RenderedImage image = coverage.getRenderedImage();
            // 获取栅格数据
            Raster raster = image.getData();
            int width = image.getWidth();
            int height = image.getHeight();
            // 创建存储像素值的集合
            List<Double> doubles = new LinkedList<>();
            // 遍历图像的每个像素，提取像素值
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    // 从样本模型和数据缓冲区中获取当前像素的值
                    double[] pixel = raster.getPixel(x, y, (double[]) null);
                    // 如果集合为空，跳过当前循环
                    if (ArrayUtil.isEmpty(pixel)) {
                        continue;
                    }
                    // 装箱
                    List<Double> boxedList = Arrays.stream(pixel)
                        .filter(d -> !Double.isNaN(d))
                        .boxed()
                        .toList();
                    if (CollectionUtils.isEmpty(boxedList)) {
                        continue;
                    }
                    doubles.add(function.apply(boxedList));
                }
            }
            return doubles;
        } finally {
            // 确保资源正确释放
            if (Objects.nonNull(coverage)) {
                coverage.dispose(true);
            }
            if (Objects.nonNull(reader)) {
                reader.dispose();
            }
        }
    }


    /**
     * bbox的重投影，直接重投影到4326
     *
     * @param bbox 这个是经纬度边框 bbox
     * @return 4326的经纬度边框
     */
    public static double[] bboxTransform(double[] bbox, CoordinateReferenceSystem sourceCRS) {
        return bboxTransform(bbox, sourceCRS, EPSG_4326);
    }


    public static double[] bboxTransform(double[] bbox, CoordinateReferenceSystem sourceCRS, CoordinateReferenceSystem targetCRS) {
        if (bbox == null || bbox.length != 4)
            throw new IllegalArgumentException("bbox的长度不是4");
        ThrowingFunction<Geometry, Stream<Double>> consumer = t -> {
            Coordinate coordinate = geometryTransform(t, sourceCRS, targetCRS).getCoordinate();
            return Stream.of(coordinate.getX(), coordinate.getY());
        };
        return IntStream.of(0, 2)
            .mapToObj(i -> GEOMETRY_FACTORY.createPoint(new Coordinate(bbox[i], bbox[i + 1])))
            .flatMap(consumer)
            .mapToDouble(d -> d)
            .toArray();
    }

    /**
     * 拓扑修复
     *
     * @param geometry 几何学
     * @return {@link Geometry}
     */
    public static Geometry topologyFix(Geometry geometry) {
        if (geometry.isValid()) {
            return geometry;
        }
        Geometry buffer = geometry.buffer(0);
        if (buffer.isValid()) {
            return buffer;
        }
        return new GeometryFixer(geometry).getResult();
    }

    public static GeometryFactory getGeometryFactory() {
        return GEOMETRY_FACTORY;
    }

    /**
     * 计算面积,单位km2
     *
     * @param sfc
     * @param targetCrs
     * @return
     */
    public static double calcArea(SimpleFeatureCollection sfc, CoordinateReferenceSystem targetCrs) {
        List<Geometry> geometries = GeoToolsUtils.fcToGeometryList(sfc);
        double totalArea = 0L;
        for (Geometry geometry : geometries) {
            totalArea += targetCrs instanceof DefaultProjectedCRS ?
                geometry.getArea() :
                GeoToolsUtils.geometryTransform(geometry, targetCrs, EPSG_3857).getArea();
        }
        return totalArea / 1000000;
    }

    /**
     * 按照某一个key对geometry分组
     *
     * @param absPath geojson 文件地址
     * @param key     key
     * @return Map
     */
    public static Map<String, List<Geometry>> groupByKey(String absPath, String key) throws IOException {

        HashMap<String, List<Geometry>> stringGeometryHashMap = new HashMap<>(8);
        try (InputStream is = Files.newInputStream(Paths.get(absPath))) {
            GeoJSONReader geoJSONReader = new GeoJSONReader(is);
            SimpleFeatureCollection features = geoJSONReader.getFeatures();
            try (SimpleFeatureIterator iterator = features.features()) {
                if (features.isEmpty()) {
                    return stringGeometryHashMap;
                }
                while (iterator.hasNext()) {
                    try {
                        SimpleFeature feature = iterator.next();
                        GeometryAttribute geometryAttribute = feature.getDefaultGeometryProperty();
                        Object attribute = feature.getAttribute(key);
                        if (attribute == null) {
                            continue;
                        }
                        // 会出现这个属性值为空的情况
                        if (geometryAttribute == null) {
                            continue;
                        }
                        Geometry value = (Geometry) geometryAttribute.getValue();
                        stringGeometryHashMap.get(attribute.toString());
                        stringGeometryHashMap.computeIfAbsent(attribute.toString(), k -> new ArrayList<>()).add(value);
                    } catch (Exception e) {
                        log.error("获取feature 元素失败：" + e);
                    }

                }
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return stringGeometryHashMap;
    }

    public static SimpleFeatureCollection reproject(SimpleFeatureCollection featureCollection, CoordinateReferenceSystem sourceCRS,
                                                    CoordinateReferenceSystem targetCRS) throws FactoryException, TransformException {
        if (featureCollection.isEmpty()) {
            return featureCollection;
        }
        // 创建转换操作
        MathTransform transform = CRS.findMathTransform(sourceCRS, targetCRS, true);

        // 创建一个新的 FeatureCollection 来存储重投影后的特征
        SimpleFeatureType featureType = featureCollection.getSchema();
        DefaultFeatureCollection reprojectedFeatureCollection = new DefaultFeatureCollection(null, featureType);

        // 遍历原始 FeatureCollection 并进行重投影
        try (SimpleFeatureIterator iterator = featureCollection.features()) {
            while (iterator.hasNext()) {
                SimpleFeature feature = iterator.next();
                // 获取原始几何对象
                Object geometry = feature.getDefaultGeometry();
                if (geometry != null) {
                    // 使用JTS库进行几何对象的重投影
                    geometry = JTS.transform((Geometry) geometry, transform);
                }
                // 构建新的 SimpleFeature
                SimpleFeatureBuilder featureBuilder = new SimpleFeatureBuilder(feature.getFeatureType());
                featureBuilder.addAll(feature.getAttributes());
                featureBuilder.set(feature.getFeatureType().getGeometryDescriptor().getLocalName(), geometry);
                SimpleFeature reprojectedFeature = featureBuilder.buildFeature(feature.getID());
                reprojectedFeatureCollection.add(reprojectedFeature);
            }
        }
        return reprojectedFeatureCollection;
    }


    /**
     * 分割bbox
     *
     * @param envelope bbox
     * @param rows     排
     * @param cols     cols
     * @return {@link List}<{@link Envelope}>
     */
    public static List<Envelope> divideEnvelope(Envelope envelope, int rows, int cols) {
        List<Envelope> subEnvelopes = new LinkedList<>();
        // Calculate the width and height of each sub-envelope
        double subWidth = envelope.getWidth() / cols;
        double subHeight = envelope.getHeight() / rows;
        // Loop through each row and column to create sub-envelopes
        for (int row = 0; row < rows; row++) {
            for (int col = 0; col < cols; col++) {
                // Calculate the coordinates of the sub-envelope
                double minX = envelope.getMinX() + col * subWidth;
                double minY = envelope.getMinY() + row * subHeight;
                double maxX = minX + subWidth;
                double maxY = minY + subHeight;
                // Correctly construct the Envelope
                Envelope subEnvelope = new Envelope(minX, maxX, minY, maxY);
                subEnvelopes.add(subEnvelope);
            }
        }
        return subEnvelopes;
    }

    /**
     * 将线段分割成多个 bounding box (包围盒)
     * 此方法用于处理地理空间数据，将给定的线段按照指定的分段长度分割成多个包围盒
     * 主要用于地理信息系统（GIS）相关的应用中，以便于空间索引或者空间分析
     *
     * @param line          线段对象，表示需要被分割的原始线段
     * @param segmentLength 分段长度，表示每个分割后包围盒的长度，单位米
     * @param lineCrs       线段的坐标参考系统，用于确定是否需要进行坐标转换
     * @return 返回包含多个包围盒的列表，每个包围盒代表线段的一个分段
     */
    public static List<Envelope> splitLineToBBoxes(LineString line, double segmentLength, CoordinateReferenceSystem lineCrs) {
        // 判断线段的坐标参考系统是否为投影坐标系统
        boolean isProjected = lineCrs instanceof DefaultProjectedCRS;
        // 如果不是投影坐标系统，则将线段转换到 3857 坐标系
        LineString validLine = isProjected ? line : (LineString) geometryTransform(line, lineCrs, EPSG_3857);
        // 如果线段长度小于了本身，那就直接返回自己的 bbox
        if (validLine.getLength() < segmentLength) {
            return Collections.singletonList(line.getEnvelopeInternal());
        }
        // 初始化用于存储包围盒的列表
        List<Envelope> bboxList = new LinkedList<>();
        // 创建 LengthLocationMap 对象，用于根据长度获取线段上的位置
        LengthLocationMap lengthLocationMap = new LengthLocationMap(validLine);
        // 获取线段的终点坐标
        Coordinate endCoordinate = validLine.getEndPoint().getCoordinate();
        // 循环分割线段
        for (int i = 0; ; i++) {
            // 起点
            Coordinate start = lengthLocationMap.getLocation(segmentLength * i).getCoordinate(validLine);
            // 终点
            Coordinate end = lengthLocationMap.getLocation(segmentLength * (i + 1)).getCoordinate(validLine);
            LineString lineString = GeoToolsUtils.creatLineString(new Coordinate[]{start, end});
            if (isProjected) {
                Envelope envelope = lineString.getEnvelopeInternal();
                bboxList.add(envelope);
            } else {
                // 如果是重投影过的，那么我们重投影到原始坐标系去
                Envelope envelopeInternal = geometryTransform(lineString, EPSG_3857, lineCrs).getEnvelopeInternal();
                bboxList.add(envelopeInternal);
            }
            // 如果终点与线段的终点坐标相同，则结束循环
            if (end.equals(endCoordinate)) {
                return bboxList;
            }
        }
    }

}

