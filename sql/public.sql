/*
 Navicat Premium Data Transfer

 Source Server         : 本地测试数据库
 Source Server Type    : PostgreSQL
 Source Server Version : 120012
 Source Host           : 172.24.49.78:15432
 Source Catalog        : iot_gps
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120012
 File Encoding         : 65001

 Date: 18/09/2025 17:41:58
*/


-- ----------------------------
-- Sequence structure for permissions_permission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."permissions_permission_id_seq";
CREATE SEQUENCE "public"."permissions_permission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for device_gga_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_gga_data";
CREATE TABLE "public"."device_gga_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "lat" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "lon" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "u_lat" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "u_lon" varchar(60) COLLATE "pg_catalog"."default" NOT NULL,
  "sv_num" int4 NOT NULL,
  "hdop" float4 NOT NULL,
  "msl" float4 NOT NULL,
  "sep" float4 NOT NULL,
  "diff_age" varchar(255) COLLATE "pg_catalog"."default",
  "diffSta" varchar(255) COLLATE "pg_catalog"."default",
  "data_time" timestamp(6) NOT NULL,
  "source_data" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_gga_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_gga_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_gga_data"."lat" IS '纬度';
COMMENT ON COLUMN "public"."device_gga_data"."lon" IS '经度';
COMMENT ON COLUMN "public"."device_gga_data"."u_lat" IS '纬度方向 北半球（N）或南半球（S）';
COMMENT ON COLUMN "public"."device_gga_data"."u_lon" IS '经度方向 东（E）半球或西（W）半球';
COMMENT ON COLUMN "public"."device_gga_data"."sv_num" IS '定位卫星数量';
COMMENT ON COLUMN "public"."device_gga_data"."hdop" IS '水平精度因子（HDOP) 范围：0.5-99.9';
COMMENT ON COLUMN "public"."device_gga_data"."msl" IS '海拔高度 单位m';
COMMENT ON COLUMN "public"."device_gga_data"."sep" IS '参考椭球面与大地水准面之间的距离 单位m';
COMMENT ON COLUMN "public"."device_gga_data"."data_time" IS '数据时间';
COMMENT ON COLUMN "public"."device_gga_data"."source_data" IS '原始数据';
COMMENT ON TABLE "public"."device_gga_data" IS '来自GGA反馈的数据，该数据带有海拔高度和坐标信息';

-- ----------------------------
-- Records of device_gga_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_gll_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_gll_data";
CREATE TABLE "public"."device_gll_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "data_time" timestamp(6),
  "lat" varchar(255) COLLATE "pg_catalog"."default",
  "lon" varchar(255) COLLATE "pg_catalog"."default",
  "u_lat" varchar(60) COLLATE "pg_catalog"."default",
  "u_lon" varchar(60) COLLATE "pg_catalog"."default",
  "mode" varchar(60) COLLATE "pg_catalog"."default",
  "source_data" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_gll_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_gll_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_gll_data"."data_time" IS '数据时间';
COMMENT ON COLUMN "public"."device_gll_data"."lat" IS '纬度';
COMMENT ON COLUMN "public"."device_gll_data"."lon" IS '经度';
COMMENT ON COLUMN "public"."device_gll_data"."u_lat" IS '北半球（N）或南半球（S）';
COMMENT ON COLUMN "public"."device_gll_data"."u_lon" IS '东（E）半球或西（W）半球';
COMMENT ON COLUMN "public"."device_gll_data"."mode" IS '定位模式 A自主模式E估算模式（航位推算）N数据无效D差分模式M未定位，但存在外部输入或历史保存的位置';
COMMENT ON COLUMN "public"."device_gll_data"."source_data" IS '原始数据';
COMMENT ON TABLE "public"."device_gll_data" IS '来自设备的GLL反馈的数据';

-- ----------------------------
-- Records of device_gll_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_gsa_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_gsa_data";
CREATE TABLE "public"."device_gsa_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "device_fs" int2,
  "satellite_chnnel" varchar(255) COLLATE "pg_catalog"."default",
  "pdop" float4,
  "vdop" float4,
  "hdop" float4,
  "device_time" timestamp(6),
  "source_data" varchar(255) COLLATE "pg_catalog"."default",
  "system_id" int2 NOT NULL
)
;
COMMENT ON COLUMN "public"."device_gsa_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_gsa_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_gsa_data"."device_fs" IS '定位模式 1定位无效 2 2D定位 3 3D定位';
COMMENT ON COLUMN "public"."device_gsa_data"."satellite_chnnel" IS '卫星使用(信号频道1),例如12，13,表示 编号12的卫星在使用信道1 编号13的卫星在使用信道2，最多12个信道';
COMMENT ON COLUMN "public"."device_gsa_data"."pdop" IS '位置精度因子（PDOP）';
COMMENT ON COLUMN "public"."device_gsa_data"."vdop" IS '垂直精度因子（HDOP）';
COMMENT ON COLUMN "public"."device_gsa_data"."hdop" IS '水平精度因子（HDOP）';
COMMENT ON COLUMN "public"."device_gsa_data"."device_time" IS '数据时间';
COMMENT ON COLUMN "public"."device_gsa_data"."source_data" IS '原始数据';
COMMENT ON COLUMN "public"."device_gsa_data"."system_id" IS '1 GPS系统 2 GLONASS系统 4 BDS系统';
COMMENT ON TABLE "public"."device_gsa_data" IS '来自设备GSA的数据';

-- ----------------------------
-- Records of device_gsa_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_gsv_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_gsv_data";
CREATE TABLE "public"."device_gsv_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "data_time" timestamp(6),
  "satellite_num" int2,
  "source_data" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_gsv_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_gsv_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_gsv_data"."data_time" IS '数据时间';
COMMENT ON COLUMN "public"."device_gsv_data"."satellite_num" IS '卫星数量';
COMMENT ON COLUMN "public"."device_gsv_data"."source_data" IS '原始数据';
COMMENT ON TABLE "public"."device_gsv_data" IS '来自设备的GSV的数据，关联device_gsv_satellite_data';

-- ----------------------------
-- Records of device_gsv_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_gsv_satellite_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_gsv_satellite_data";
CREATE TABLE "public"."device_gsv_satellite_data" (
  "id" int8 NOT NULL,
  "data_id" int8 NOT NULL,
  "satellite_code" varchar(255) COLLATE "pg_catalog"."default",
  "satellite_ele" varchar(255) COLLATE "pg_catalog"."default",
  "satellite_az" varchar(255) COLLATE "pg_catalog"."default",
  "satellite_cno" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."id" IS 'id';
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."data_id" IS '数据id 来自device_gsv_data表id字段';
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."satellite_code" IS '卫星编号';
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."satellite_ele" IS '卫星仰角';
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."satellite_az" IS '卫星方位角';
COMMENT ON COLUMN "public"."device_gsv_satellite_data"."satellite_cno" IS '讯号噪声比';
COMMENT ON TABLE "public"."device_gsv_satellite_data" IS '卫星的方位角以及倾角信息，与device_gsv_data表关联';

-- ----------------------------
-- Records of device_gsv_satellite_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_info
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_info";
CREATE TABLE "public"."device_info" (
  "id" int8 NOT NULL,
  "device_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "init_time" timestamp(6) NOT NULL,
  "user_id" int8 NOT NULL,
  "mac" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_info"."id" IS '主键 设备id';
COMMENT ON COLUMN "public"."device_info"."device_name" IS '设备名称';
COMMENT ON COLUMN "public"."device_info"."init_time" IS '设备注册时间';
COMMENT ON COLUMN "public"."device_info"."user_id" IS '关联的用户id';
COMMENT ON COLUMN "public"."device_info"."mac" IS '设备mac地址';
COMMENT ON TABLE "public"."device_info" IS 'GPS设备信息表';

-- ----------------------------
-- Records of device_info
-- ----------------------------
INSERT INTO "public"."device_info" VALUES (1, '王长奎的ESP32', '2025-06-15 18:16:11', 1, 'D4-E9-8A-12-13-85');

-- ----------------------------
-- Table structure for device_rmc_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_rmc_data";
CREATE TABLE "public"."device_rmc_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "data_time" timestamp(6),
  "lon" varchar(255) COLLATE "pg_catalog"."default",
  "lat" varchar(255) COLLATE "pg_catalog"."default",
  "u_lat" varchar(30) COLLATE "pg_catalog"."default",
  "u_lon" varchar(30) COLLATE "pg_catalog"."default",
  "speed" float8,
  "cog" float8,
  "mv" float8,
  "mv_e" varchar(255) COLLATE "pg_catalog"."default",
  "source_data" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_rmc_data"."id" IS 'id';
COMMENT ON COLUMN "public"."device_rmc_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_rmc_data"."data_time" IS '定位数据时间';
COMMENT ON COLUMN "public"."device_rmc_data"."lon" IS '经度';
COMMENT ON COLUMN "public"."device_rmc_data"."lat" IS '纬度';
COMMENT ON COLUMN "public"."device_rmc_data"."u_lat" IS '南北半球标识符 N 北半球 S 南半球';
COMMENT ON COLUMN "public"."device_rmc_data"."u_lon" IS '经度方向 E 东半球 W 西半球';
COMMENT ON COLUMN "public"."device_rmc_data"."speed" IS '速度 单位 节';
COMMENT ON COLUMN "public"."device_rmc_data"."cog" IS '对地真航向';
COMMENT ON COLUMN "public"."device_rmc_data"."mv" IS '磁偏角';
COMMENT ON COLUMN "public"."device_rmc_data"."mv_e" IS '磁偏角方向';
COMMENT ON COLUMN "public"."device_rmc_data"."source_data" IS '原始数据';
COMMENT ON TABLE "public"."device_rmc_data" IS '来自设备的RMC格式的数据';

-- ----------------------------
-- Records of device_rmc_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_temp_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_temp_data";
CREATE TABLE "public"."device_temp_data" (
  "id" int8 NOT NULL,
  "time" timestamp(6) NOT NULL,
  "device_id" int8 NOT NULL,
  "temp_data" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."device_temp_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_temp_data"."time" IS '数据时间';
COMMENT ON COLUMN "public"."device_temp_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_temp_data"."temp_data" IS '获取到的临时数据';
COMMENT ON TABLE "public"."device_temp_data" IS '记录获取到的数据 临时的';

-- ----------------------------
-- Records of device_temp_data
-- ----------------------------
INSERT INTO "public"."device_temp_data" VALUES (1934214085604405248, '2025-06-15 19:39:08.625287', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934214090260082688, '2025-06-15 19:39:09.735083', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934214095251304448, '2025-06-15 19:39:10.924616', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214100431269888, '2025-06-15 19:39:12.16016', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214105376354304, '2025-06-15 19:39:13.339903', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1934214110686343168, '2025-06-15 19:39:14.605065', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934214115555930112, '2025-06-15 19:39:15.766889', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934214120417128448, '2025-06-15 19:39:16.925824', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934214125186052096, '2025-06-15 19:39:18.061681', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934214135998967808, '2025-06-15 19:39:20.640659', 1, '$GPTXT,01,01,02,SW=URANUS5,V5.3.0.0*1D');
INSERT INTO "public"."device_temp_data" VALUES (1934214146165960704, '2025-06-15 19:39:23.064216', 1, '$GPTXT,01,01,02,IC=AT6558R-5N-32-1C580901*13');
INSERT INTO "public"."device_temp_data" VALUES (1934214151350120448, '2025-06-15 19:39:24.300399', 1, '$GPTXT,01,01,02,SW=URANUS5,V5.3.0.0*1D');
INSERT INTO "public"."device_temp_data" VALUES (1934214156643332096, '2025-06-15 19:39:25.562843', 1, '$GPTXT,01,01,02,TB=2020-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934214161512919040, '2025-06-15 19:39:26.723631', 1, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1934214171365339136, '2025-06-15 19:39:29.072124', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934214176130068480, '2025-06-15 19:39:30.208358', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934214180953518080, '2025-06-15 19:39:31.357702', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934214185995071488, '2025-06-15 19:39:32.560394', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214190847881216, '2025-06-15 19:39:33.717926', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214195751022592, '2025-06-15 19:39:34.886004', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1934214200595443712, '2025-06-15 19:39:36.041269', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934214205444059136, '2025-06-15 19:39:37.197665', 1, '$,39,32,,,43,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1934214210468835328, '2025-06-15 19:39:38.39532', 1, '$BDGSV,1,1,01,05,,,38,0*7B');
INSERT INTO "public"."device_temp_data" VALUES (1934214215468445696, '2025-06-15 19:39:39.587777', 1, '$GNRMC,113931.487,V,,,,,,,,,,N000,,,,,*49');
INSERT INTO "public"."device_temp_data" VALUES (1934214220350615552, '2025-06-15 19:39:40.751567', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214225350225920, '2025-06-15 19:39:41.943773', 1, '$GNGGA,113939.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934214230140121088, '2025-06-15 19:39:43.085149', 1, '$GNGLL,,,,,113939.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1934214235026485248, '2025-06-15 19:39:44.250131', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214239925432320, '2025-06-15 19:39:45.418367', 1, '$GNGSA,A,1,,,,,,,,');
INSERT INTO "public"."device_temp_data" VALUES (1934214244782436352, '2025-06-15 19:39:46.576113', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214249572331520, '2025-06-15 19:39:47.71875', 1, '$GNGGA,113948.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1934214254420946944, '2025-06-15 19:39:48.874462', 1, '$GNGLL,,,,,113948.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1934214259131150336, '2025-06-15 19:39:49.997009', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214263837159424, '2025-06-15 19:39:51.119233', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214268522196992, '2025-06-15 19:39:52.236481', 1, '$GPGSV,2,1,05,10,,,29,12,,,36,28,,,38,31,,,32,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934214273400172544, '2025-06-15 19:39:53.3998', 1, '$GPGSV,2,2,34,0*73');
INSERT INTO "public"."device_temp_data" VALUES (1934214278383005696, '2025-06-15 19:39:54.58784', 1, '$GNRMC,113951.000,V,,,,,,,,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1934214283202260992, '2025-06-15 19:39:55.73666', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934214288004739072, '2025-06-15 19:39:56.881674', 1, '$GNZDA,113951.000,,,,,*46');
INSERT INTO "public"."device_temp_data" VALUES (1934214292706553856, '2025-06-15 19:39:58.002394', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214297500643328, '2025-06-15 19:39:59.145656', 1, '*73');
INSERT INTO "public"."device_temp_data" VALUES (1934214302370230272, '2025-06-15 19:40:00.306027', 1, '$GNGLL,,,,,113956.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934214307118182400, '2025-06-15 19:40:01.438383', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214312247816192, '2025-06-15 19:40:02.661302', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214317251620864, '2025-06-15 19:40:03.854388', 1, '$GPGS,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1934214322213482496, '2025-06-15 19:40:05.037909', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934214327145984000, '2025-06-15 19:40:06.213236', 1, '$GNZDA,114002.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934214331889741824, '2025-06-15 19:40:07.344989', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214337124233216, '2025-06-15 19:40:08.592562', 1, '$GNGGA,114003.000,,,,,0,00,25.5,,');
INSERT INTO "public"."device_temp_data" VALUES (1934214341947682816, '2025-06-15 19:40:09.742309', 1, '$GNGGA,114007.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1934214347031179264, '2025-06-15 19:40:10.954712', 1, '$GNGLL,,,,,114007.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1934214351833657344, '2025-06-15 19:40:12.099434', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214356569026560, '2025-06-15 19:40:13.228047', 1, '$,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214361514110976, '2025-06-15 19:40:14.407699', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214366505332736, '2025-06-15 19:40:15.597459', 1, '$GPGSV,2,1,05,10,,,27,12,,,35,28,,,38,31,,,33,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1934211570863304704, '2025-06-15 19:29:09.064313', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211575661588480, '2025-06-15 19:29:10.208616', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211585316876288, '2025-06-15 19:29:12.510247', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934211590027079680, '2025-06-15 19:29:13.633682', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934211594670174208, '2025-06-15 19:29:14.740725', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934211599367794688, '2025-06-15 19:29:15.86002', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211604052832256, '2025-06-15 19:29:16.9779', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211608721092608, '2025-06-15 19:29:18.090129', 1, '$GNGGA,,,,,,0,00,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934211613502599168, '2025-06-15 19:29:19.230056', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934211618208608256, '2025-06-15 19:29:20.351495', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211623208218624, '2025-06-15 19:29:21.544957', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211632406327296, '2025-06-15 19:29:23.7377', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211637041033216, '2025-06-15 19:29:24.842396', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211641650573312, '2025-06-15 19:29:25.941555', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934211646297862144, '2025-06-15 19:29:27.049559', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934211739012952064, '2025-06-15 19:29:49.154725', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934211743781875712, '2025-06-15 19:29:50.291182', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934211748492079104, '2025-06-15 19:29:51.414986', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934211753277779968, '2025-06-15 19:29:52.555509', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211758050897920, '2025-06-15 19:29:53.693018', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211762714963968, '2025-06-15 19:29:54.805519', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934211767425167360, '2025-06-15 19:29:55.928573', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934211772374446080, '2025-06-15 19:29:57.108881', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934211777164341248, '2025-06-15 19:29:58.250013', 1, '$GNGSA,A,1,,,,,,,,,,,,,2');
INSERT INTO "public"."device_temp_data" VALUES (1934211781815824384, '2025-06-15 19:29:59.35904', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934211786446336000, '2025-06-15 19:30:00.463871', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934211791085236224, '2025-06-15 19:30:01.569089', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934211796311339008, '2025-06-15 19:30:02.815078', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211800925073408, '2025-06-15 19:30:03.915247', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211805601722368, '2025-06-15 19:30:05.030203', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934211810249011200, '2025-06-15 19:30:06.138288', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934211814921465856, '2025-06-15 19:30:07.252499', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934211819518423040, '2025-06-15 19:30:08.348314', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*V,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1934211824136351744, '2025-06-15 19:30:09.449029', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1934211828729114624, '2025-06-15 19:30:10.543561', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1934211833309294592, '2025-06-15 19:30:11.636623', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1934211837990137856, '2025-06-15 19:30:12.752528', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934211842666786816, '2025-06-15 19:30:13.867847', 1, '$GNGGA,,');
INSERT INTO "public"."device_temp_data" VALUES (1934214371295227904, '2025-06-15 19:40:16.739995', 1, '$GPGSV,2,2GNZDA,114014.000,15,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934214376055762944, '2025-06-15 19:40:17.874387', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214381395111936, '2025-06-15 19:40:19.147944', 1, '$GNGGA,114015.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934214386407305216, '2025-06-15 19:40:20.342523', 1, '$GN25');
INSERT INTO "public"."device_temp_data" VALUES (1934214391461441536, '2025-06-15 19:40:21.547672', 1, '$GNGGA,114023.000,3028.00676,N,10406.50338,E,1,07,1.5,617.7,M,-43.0,M,,*69');
INSERT INTO "public"."device_temp_data" VALUES (1934214396150673408, '2025-06-15 19:40:22.665648', 1, '$GNGLL,3028.00676,N,10406.50338,E,114023.000,A,A*42');
INSERT INTO "public"."device_temp_data" VALUES (1934214401020260352, '2025-06-15 19:40:23.826852', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.1,1.5,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934214406149894144, '2025-06-15 19:40:25.04975', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.1,1.5,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934214411061424128, '2025-06-15 19:40:26.22005', 1, '$GPGSV,2,1,05,10,63,343,27,12,24T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214415910039552, '2025-06-15 19:40:27.376714', 1, '$GNZDA,114028.000,15,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1934214421064839168, '2025-06-15 19:40:28.605661', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214426026700800, '2025-06-15 19:40:29.788149', 1, '$GNGGA,114029.000,3028.00894,N,10406.50292,E,1,07,1.5,606.7,M,-43.0,M,,*60');
INSERT INTO "public"."device_temp_data" VALUES (1934214430787235840, '2025-06-15 19:40:30.923959', 1, '$GNGLL,3028.00894,N,10406.50292,E,114029.000,A,A*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934214435514216448, '2025-06-15 19:40:32.050731', 1, '$GNGSA,A,3,10,12,28,31,32.50292,E,1,07,1.5,605.1,M,-43.0,M,,*69');
INSERT INTO "public"."device_temp_data" VALUES (1934214440375414784, '2025-06-15 19:40:33.209578', 1, '$GNGLL,3028.00880,N,10406.50292,E,114031.000,A,A*47');
INSERT INTO "public"."device_temp_data" VALUES (1934214445098201088, '2025-06-15 19:40:34.335436', 1, '$GNGSA,A,3,10,10.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214450383024128, '2025-06-15 19:40:35.595946', 1, '$GNZDA,114034.000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934214455281971200, '2025-06-15 19:40:36.76314', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214459946037248, '2025-06-15 19:40:37.875489', 1, '$GNGGA,114035.000,3028.00856,N,10406.50296,E,1,07,1.5,60,1,1,04,02,,,32,05,,,39,19,30,309,39,29,20,240,34,0*7F');
INSERT INTO "public"."device_temp_data" VALUES (1934214464710766592, '2025-06-15 19:40:39.011023', 1, '$GNRMC,114039.000,A,3028.00855,N,10406.50272,E,0.00,0.00,150625,,,A,V*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214469425164288, '2025-06-15 19:40:40.135201', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214474303139840, '2025-06-15 19:40:41.298088', 1, '$GNZDA,114039.000,15,06,2025,00,00T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214479210475520, '2025-06-15 19:40:42.468882', 1, '$GNZDA,114040.000,15,06,2025,0.0,M,,*63');
INSERT INTO "public"."device_temp_data" VALUES (1934214484059090944, '2025-06-15 19:40:43.624871', 1, '$GNGLL,3028.00847,N,10406.50294,E,114045.000,A,A*49');
INSERT INTO "public"."device_temp_data" VALUES (1934214488941260800, '2025-06-15 19:40:44.787404', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.1,1.5,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934214493794070528, '2025-06-15 19:40:45.945968', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.1,1.5,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934214498516856832, '2025-06-15 19:40:47.071531', 1, '$GPGSV,2,1,07,02,07,321,,10,63,343,26,12,24,097,34,25,27,135,,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1934214503252226048, '2025-06-15 19:40:48.19982', 1, '$GPGSV,2,2,07,28,34,217,37,31,06,217,32,,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214508096647168, '2025-06-15 19:40:49.355328', 1, '$GNGGA,114051.000,3028.00877,N,10406.50305,E,1,07,1.5,605.8,M,-43.0,M,,*61');
INSERT INTO "public"."device_temp_data" VALUES (1934214513259835392, '2025-06-15 19:40:50.586275', 1, '$GNGLL,3028.00877,N,10406.50305,E,114051.000,A,A*46');
INSERT INTO "public"."device_temp_data" VALUES (1934214518267834368, '2025-06-15 19:40:51.780473', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.1,1.5,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934214523137421312, '2025-06-15 19:40:52.941185', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.1,1.5,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934214528036368384, '2025-06-15 19:40:54.10975', 1, '$GPGSV,2,1,07,02,07,321,,10,63,3406.50299,E,0.00,0.00,150625,,,A,V*02');
INSERT INTO "public"."device_temp_data" VALUES (1934214532859817984, '2025-06-15 19:40:55.259288', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214537725210624, '2025-06-15 19:40:56.41963', 1, '$GNZDA,114055.000,15,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934214542636740608, '2025-06-15 19:40:57.590545', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214547686682624, '2025-06-15 19:40:58.79436', 1, '$GNGGA,114056.000,3028.00887,N,10406.50298,E,1,07,1.5,605.5,M,-43.0,M,,GNZDA,114058.000,15,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1934214552518520832, '2025-06-15 19:40:59.946632', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214557367136256, '2025-06-15 19:41:01.102688', 1, '$GNGGA,114059.000,3028.00880,N,10406.50293,E,1,07,1.');
INSERT INTO "public"."device_temp_data" VALUES (1934214562370940928, '2025-06-15 19:41:02.295741', 1, '$BDGSV,2,1,05,02,,,32,05,,,40,19,30,309,38,29,20,239,32,0*7A');
INSERT INTO "public"."device_temp_data" VALUES (1934214567659958272, '2025-06-15 19:41:03.556843', 1, '$BDGSV,2,2,05,32,,,36,0*75');
INSERT INTO "public"."device_temp_data" VALUES (1934214572969947136, '2025-06-15 19:41:04.822708', 1, '$GNRMC,114101.000,A,3028.00875,N,10406.500,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214577868894208, '2025-06-15 19:41:05.99038', 1, '$GNZDA,114104.000,15,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934214582847533056, '2025-06-15 19:41:07.177349', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214587939418112, '2025-06-15 19:41:08.391738', 1, '$GNGGA,114105.000,3028.00876,N,10406.50261,E,1,07,1.5,');
INSERT INTO "public"."device_temp_data" VALUES (1934214592997748736, '2025-06-15 19:41:09.597377', 1, '$GPGSV,2,1,07,02,07,321,,10,64,343,25,12,24,097,33,25,27,135,,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934214598156742656, '2025-06-15 19:41:10.827526', 1, '$GPGSV,2,2,07,28,34,217,37,31,06,217,30,32,47,303,2,47,303,40,0*57');
INSERT INTO "public"."device_temp_data" VALUES (1934214602929860608, '2025-06-15 19:41:11.96585', 1, '$BDGSV,2,1,05,02,,,32,05,,,40,19,30,309,38,29,20,239,36,0*7E');
INSERT INTO "public"."device_temp_data" VALUES (1934214607723950080, '2025-06-15 19:41:13.108484', 1, '$BDGSV,2,2,05,32,,,35,0*76');
INSERT INTO "public"."device_temp_data" VALUES (1934214612446736384, '2025-06-15 19:41:14.234965', 1, '$GNRMC,114113.000,A,3028.00958,N,10406.50219,E,0.00,0.00,150625,,,A,V*09');
INSERT INTO "public"."device_temp_data" VALUES (1934214617219854336, '2025-06-15 19:41:15.372366', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214621984583680, '2025-06-15 19:41:16.508844', 1, '$GNZDA,114113.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934214626875142144, '2025-06-15 19:41:17.674025', 1, '$GPTXT,01,01,01,A5,599.2,M,-43.0,M,,*67');
INSERT INTO "public"."device_temp_data" VALUES (1934214631644065792, '2025-06-15 19:41:18.811413', 1, '$GNGLL,3028.00973,N,10406.50217,E,114119.000,A,A*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934214636601733120, '2025-06-15 19:41:19.993219', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.1,1.5,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934214641387433984, '2025-06-15 19:41:21.134282', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.1,1.5,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934214646106025984, '2025-06-15 19:41:22.259659', 1, '$GPGSV,2,1,08,02,07,321,,10,64,343,23,12,24,097,33,18,,,28,0*55MC,114122.000,A,3028.00961,N,10406.50221,E,0.00,0.00,150625,,,A,V*0A');
INSERT INTO "public"."device_temp_data" VALUES (1934214650866561024, '2025-06-15 19:41:23.394989', 1, '$GNVTG,0.00,T,,M,0.00,N,0.0000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934214655803256832, '2025-06-15 19:41:24.571664', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214660651872256, '2025-06-15 19:41:25.727428', 1, '$GNGGA,114125.000,3028.00946,N,10406.50228,E,1,07,1.5,600.5,M,-43.0,M,,*66');
INSERT INTO "public"."device_temp_data" VALUES (1934214665370464256, '2025-06-15 19:41:26.85298', 1, '$GNGLL,3028.00946,N,1040649');
INSERT INTO "public"."device_temp_data" VALUES (1934214670156165120, '2025-06-15 19:41:27.993484', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.1,1.5,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934214674874757120, '2025-06-15 19:41:29.1181', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.1,1.5,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934214679614320640, '2025-06-15 19:41:30.248702', 1, '$GPGSV,2,1,08,02,07,321,,10,64,343,23,12,24,097,34,18,,,5,32,,,36,0*75');
INSERT INTO "public"."device_temp_data" VALUES (1934214684324524032, '2025-06-15 19:41:31.371928', 1, '$GNRMC,114129.000,A,3028.00930,N,10406.50238,E,0.00,0.00,150625,,,A,V*0D');
INSERT INTO "public"."device_temp_data" VALUES (1934214689168945152, '2025-06-15 19:41:32.526787', 1, '$GNVTG,0.0000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934214694487322624, '2025-06-15 19:41:33.794157', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214699738591232, '2025-06-15 19:41:35.046561', 1, '$GNGGA,114134.000,3028.00934,N,10406.50239,E,1,08,1.3,601.2,M,-43.0,M,,*6C');
INSERT INTO "public"."device_temp_data" VALUES (1934214705371541504, '2025-06-15 19:41:36.389662', 1, '$GNGLL,3028.00934,N,10406.50239,E,114134.000,A,A*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934214711033851904, '2025-06-15 19:41:37.73949', 1, '$GNGSA,A,3,103028.00939,N,10406.50239,E,1,08,1.3,601.0,M,-43.0,M,,*62');
INSERT INTO "public"."device_temp_data" VALUES (1934214716276731904, '2025-06-15 19:41:38.989542', 1, '$GNGLL,3028.00939,N,10406.50239,E,114135.000,A,A*40,01,02,TB=2020-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934214721699966976, '2025-06-15 19:41:40.282054', 1, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1934214727521660928, '2025-06-15 19:41:41.670472', 1, '$GNGGA,114141.072,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1934214733125251072, '2025-06-15 19:41:43.006326', 1, '$GNGLL,,,,,114141.072,V,M*62');
INSERT INTO "public"."device_temp_data" VALUES (1934214738464600064, '2025-06-15 19:41:44.279642', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214744093356032, '2025-06-15 19:41:45.621423', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.M*2D');
INSERT INTO "public"."device_temp_data" VALUES (1934214749344624640, '2025-06-15 19:41:46.873293', 1, '$GNZDA,114141.072,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934214754428121088, '2025-06-15 19:41:48.085816', 1, '$GNGGA,114142.000,10406.49094,E,1,08,1.3,601.9,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934214759658418176, '2025-06-15 19:41:49.332614', 1, '$GNGLL,3028.01105,N,10406.49094,E,114148.000,A,A*41');
INSERT INTO "public"."device_temp_data" VALUES (1934214765215870976, '2025-06-15 19:41:50.657299', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934214770353893376, '2025-06-15 19:41:51.882632', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3G,0.00,T,,M,0.07,N,0.13,K,A*26');
INSERT INTO "public"."device_temp_data" VALUES (1934214775877791744, '2025-06-15 19:41:53.199103', 1, '$GNZDA,114149.992,15,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1934214781552685056, '2025-06-15 19:41:54.55293', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214790004207616, '2025-06-15 19:41:56.567681', 1, ',,,38,09,,,38,19,30,309,41,0*48');
INSERT INTO "public"."device_temp_data" VALUES (1934214795096092672, '2025-06-15 19:41:57.781749', 1, '$BDGSV,2,2,06,29,20,239,38,32,28,086,23,0*7C');
INSERT INTO "public"."device_temp_data" VALUES (1934214800318001152, '2025-06-15 19:41:59.026549', 1, '$GNRMC,114154.000,A,3028.01159,N,10406.49337,E,0.17,0.00,150625,,,A,V*011,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214818500308992, '2025-06-15 19:42:03.361342', 1, '$GNGGA,114159.000,3028.01291,N,10406.49513,E,1,08,1.3,600.4,M,-43.0,M,,*62');
INSERT INTO "public"."device_temp_data" VALUES (1934214823957098496, '2025-06-15 19:42:04.662198', 1, '$GNGLL,3028.01291,N,10424,0*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934214829220950016, '2025-06-15 19:42:05.91704', 1, '$GNRMC,114201.000,A,3028.01329,N,10406.49562,E,0.00,0.00,150625,,,A,V*07');
INSERT INTO "public"."device_temp_data" VALUES (1934214834233143296, '2025-06-15 19:42:07.112607', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214839161450496, '2025-06-15 19:42:08.287294', 1, '$GNZDA,11420$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1934214844114923520, '2025-06-15 19:42:09.468157', 1, '$GNGGA,114208.944,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1934214849424912384, '2025-06-15 19:42:10.734803', 1, '$GNGLL,,,,,114208.944,V,M*60');
INSERT INTO "public"."device_temp_data" VALUES (1934214854810398720, '2025-06-15 19:42:12.018703', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1934214860019724288, '2025-06-15 19:42:13.260846', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1934214864830590976, '2025-06-15 19:42:14.407063', 1, '$GPGSV,2,1,07,02,08,321,,10,64,344,32,12,25,096,,25,27,134,,6,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934214869855367168, '2025-06-15 19:42:15.605106', 1, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1934214888423550976, '2025-06-15 19:42:20.032536', 1, '$GPTXT,01,01,02,IC=AT6558R-5N-32-1C580901*13');
INSERT INTO "public"."device_temp_data" VALUES (1934214893683208192, '2025-06-15 19:42:21.28578', 1, '$GPTXT,01,01,02,SW=URANUS5,V5.3.0.0*1D,,,,,,M*2D');
INSERT INTO "public"."device_temp_data" VALUES (1934214898418577408, '2025-06-15 19:42:22.415999', 1, '$GNZDA,114219.822,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934214903082643456, '2025-06-15 19:42:23.527741', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214907809624064, '2025-06-15 19:42:24.654444', 1, '$GNGGA,114221.014,3028.00797,N,10406.50149,E,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214912486273024, '2025-06-15 19:42:25.76941', 1, '$GNGGA,114224.000,3028.00882,N,10406.50134,E,6,08,1.3,595.9,M,-43.0,M,,*6E');
INSERT INTO "public"."device_temp_data" VALUES (1934214917255196672, '2025-06-15 19:42:26.906519', 1, '$GNGLL,3028.00882,N,10406.50134,E,25,27,134,,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1934214922334498816, '2025-06-15 19:42:28.117994', 1, '$GPGSV,2,2,07,28,35,218,36,31,07,217,34,32,47,304,41,0*56');
INSERT INTO "public"."device_temp_data" VALUES (1934214927195697152, '2025-06-15 19:42:29.276109', 1, '$BDGSV,2,1,05,02,,,33,05,,,31,19,30,310,34,29,20,239,30,0*7B');
INSERT INTO "public"."device_temp_data" VALUES (1934214931889123328, '2025-06-15 19:42:30.395712', 1, '$BDGSV,2,NRMC,114229.000,A,3028.00984,N,10406.50080,E,0.34,0.00,150625,,,A,V*07');
INSERT INTO "public"."device_temp_data" VALUES (1934214936955842560, '2025-06-15 19:42:31.603372', 1, '$GNVTG,0.00,T,,M,0.34,N,0.63,K,A*21');
INSERT INTO "public"."device_temp_data" VALUES (1934214942198722560, '2025-06-15 19:42:32.85349', 1, ',114234.000,A,A*42');
INSERT INTO "public"."device_temp_data" VALUES (1934214947391270912, '2025-06-15 19:42:34.090801', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934214952290217984, '2025-06-15 19:42:35.259385', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934214957080113152, '2025-06-15 19:42:36.401129', 1, '$GPGSV,2,1,07,02,08,321,,10,64,344,22,12,25,096,31,25,27,134,,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1934214961790316544, '2025-06-15 19:42:37.523936', 1, '$GPGSV,2,2,07,28,35,218,27,31,07,217,41,32,47,304,26,0*55');
INSERT INTO "public"."device_temp_data" VALUES (1934214966513102848, '2025-06-15 19:42:38.650701', 1, '$BDGSV,2,1,2');
INSERT INTO "public"."device_temp_data" VALUES (1934214971365912576, '2025-06-15 19:42:39.807769', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934214976122253312, '2025-06-15 19:42:40.941304', 1, '$GNZDA,114236.000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934214980832456704, '2025-06-15 19:42:42.064548', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934214985500717056, '2025-06-15 19:42:43.177181', 1, 'GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934214990395469824, '2025-06-15 19:42:44.344692', 1, '$GPGSV,2,1,07,02,08,321,,10,64,344,22,12,25,096,33,25,27,134,,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1934214995130839040, '2025-06-15 19:42:45.473843', 1, '$GPGSV,2,2,07,28,35,218,27,31,N,10406.49975,E,1,08,1.3,588.9,M,-43.0,M,,*69');
INSERT INTO "public"."device_temp_data" VALUES (1934214999950094336, '2025-06-15 19:42:46.622537', 1, '$GNGLL,3028.01220,N,10406.49975,E,114248.000,A,A*40');
INSERT INTO "public"."device_temp_data" VALUES (1934215004748378112, '2025-06-15 19:42:47.766531', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215009513107456, '2025-06-15 19:42:48.902833', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215014240088064, '2025-06-15 19:42:50.02969', 1, '$GPGSV,2,1,07,02,08,321,,10,64,344,22,12,25,096,34,25,27,1,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215019113869312, '2025-06-15 19:42:51.191075', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215023907958784, '2025-06-15 19:42:52.334131', 1, '$GPGSV,2,1,07,02,08,321,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215028966289408, '2025-06-15 19:42:53.540343', 1, '$GNZDA,114252.000,15,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934215033747795968, '2025-06-15 19:42:54.680176', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215038416056320, '2025-06-15 19:42:55.793594', 1, '$GNGGA,114253.000,3028.01218,N,10406.49972,E,1,08,1.3,588.9,M,-43.0,M,,*6F');
INSERT INTO "public"."device_temp_data" VALUES (1934215043281448960, '2025-06-15 19:42:56.953843', 1, '$GNGLL,3028.034,,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1934215048104898560, '2025-06-15 19:42:58.10354', 1, '$GPGSV,2,2,07,28,35,218,29,31,07,217,41,32,47,304,31,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1934215052789936128, '2025-06-15 19:42:59.220194', 1, '$BDGSV,1,1,03,19,30,310,36,29,20,239,39,32,28,086,28,0*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215057563054080, '2025-06-15 19:43:00.358983', 1, '$GNRMC,114257.000,A,3028.01213,N,10406.45,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1934215062424252416, '2025-06-15 19:43:01.517585', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215067390308352, '2025-06-15 19:43:02.701268', 1, '$GNGGA,114300.000,3028.01220,N,10406.49980,DA,114302.000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215072234729472, '2025-06-15 19:43:03.856283', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215076911378432, '2025-06-15 19:43:04.971151', 1, '$GNGGA,114303.000,3028.01224,N,10406.49983,E,1,08,1.3,588.3,M,-43.0,M,,*60');
INSERT INTO "public"."device_temp_data" VALUES (1934215081596416000, '2025-06-15 19:43:06.088944', 1, '$GNGLL,3028.01224,N,10406.4998,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215086348562432, '2025-06-15 19:43:07.221983', 1, '$GPGSV,2,1,07,02,08,321,,10,64,344,24,12,25,096,34,25,28,13*06');
INSERT INTO "public"."device_temp_data" VALUES (1934215091130068992, '2025-06-15 19:43:08.361731', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215096058376192, '2025-06-15 19:43:09.536894', 1, '$GNZDA,114309.000,15,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1934215101011849216, '2025-06-15 19:43:10.717065', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215105768189952, '2025-06-15 19:43:11.851056', 1, '$GNGGA,114310.000,3028.01225,N,10406.49986,E,1,08,1.3,587.8,M,-43.0,M,,*62');
INSERT INTO "public"."device_temp_data" VALUES (1934215110637776896, '2025-06-15 19:43:13.012125', 1, '$GNGLL,3028.01225,N,10406.49986,E,114310.000,A,A*45');
INSERT INTO "public"."device_temp_data" VALUES (1934215115524141056, '2025-06-15 19:43:14.177876', 1, '$GNGSA,A,3,100*62');
INSERT INTO "public"."device_temp_data" VALUES (1934215120255315968, '2025-06-15 19:43:15.305069', 1, '$GPGSV,2,2,07,28,35,218,28,31,07,217,41,32,48,304,21,0*52');
INSERT INTO "public"."device_temp_data" VALUES (1934215125003268096, '2025-06-15 19:43:16.437694', 1, '$BDGSV,1,1,03,19,30,310,35,29,20,239,36,32,28,086,5,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215129780580352, '2025-06-15 19:43:17.576687', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215134717276160, '2025-06-15 19:43:18.75313', 1, '$GNGGA,114317.000,3028.01213,N,10406.49971,E,1,08,1.3,587.7,M,-43.0,M,,*67');
INSERT INTO "public"."device_temp_data" VALUES (1934215139721080832, '2025-06-15 19:43:19.946648', 1, '$GNGLL,3028.01213,N,20.000,A,A*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934215144456450048, '2025-06-15 19:43:21.07533', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215149091155968, '2025-06-15 19:43:22.180932', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215153822330880, '2025-06-15 19:43:23.308593', 1, '$GPGSV,2,1,07,02,08,321,,10,65,344,15,12,25,096,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215158654169088, '2025-06-15 19:43:24.460044', 1, '$GNZDA,114322.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215163339206656, '2025-06-15 19:43:25.577656', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215167927775232, '2025-06-15 19:43:26.671366', 1, '$000,A,A*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934215172596035584, '2025-06-15 19:43:27.784562', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215177218158592, '2025-06-15 19:43:28.886025', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215181806727168, '2025-06-15 19:43:29.980311', 1, '$GPGSV,2,1,07,02,08,321,,10,65,344,23,12,25,096,34,25,28,134,,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1934215186395295744, '2025-06-15 19:43:31.074935', 1, '$GPGSV,2,2,07,28,35,218,29,31,07,217,41,32,48,304,18,0*59');
INSERT INTO "public"."device_temp_data" VALUES (1934215191009030144, '2025-06-15 19:43:32.174715', 1, '$BDGSV,1,1,03,19,30000,15,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215195530489856, '2025-06-15 19:43:33.252291', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215200202944512, '2025-06-15 19:43:34.366334', 1, '$GNGGA,114335.000,3028.01241,N,10406.49970,E,1,08,1.3,587.2,M,-43.0,M,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934215204825067520, '2025-06-15 19:43:35.468758', 1, '$GNGLL,3028.01241,N,10406.49970,E,114335.000,A,A*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215209367498752, '2025-06-15 19:43:36.551726', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215213968650240, '2025-06-15 19:43:37.648984', 1, '$GNGSA,A,3,19,29,3A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215218636910592, '2025-06-15 19:43:38.761304', 1, '$GNGGA,114336.000,3028.01241,N,10406.49970,E,1,008,321,,10,65,344,18,12,25,095,36,25,28,134,,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1934215223275810816, '2025-06-15 19:43:39.867841', 1, '$GPGSV,2,2,07,28,35,218,28,31,07,217,38,32,48,305,28,0*54');
INSERT INTO "public"."device_temp_data" VALUES (1934215227855990784, '2025-06-15 19:43:40.959287', 1, '$BDGSV,1,1,03,19,30,310,39,29,20,239,29,32,28,086,23,0*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215232419393536, '2025-06-15 19:43:42.047271', 1, '$GNRMC,114340.000,A,3028.0122');
INSERT INTO "public"."device_temp_data" VALUES (1934215237104431104, '2025-06-15 19:43:43.164024', 1, '$GNRMC,114342.000,A,3028.01229,N,10406.49968,E,0.00,0.00,150625,,,A,V*06');
INSERT INTO "public"."device_temp_data" VALUES (1934215241760108544, '2025-06-15 19:43:44.27419', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215246310928384, '2025-06-15 19:43:45.359259', 1, '$GNZDA,11434200,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215251012743168, '2025-06-15 19:43:46.480176', 1, '$GNZDA,114344.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215255630671872, '2025-06-15 19:43:47.581291', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215260303126528, '2025-06-15 19:43:48.695442', 1, '$GNGGA,114345.000,3028.01221,N,10406.49,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215265105604608, '2025-06-15 19:43:49.839775', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215269799030784, '2025-06-15 19:43:50.959391', 1, '$GPGSV,2,1,07,02,08,320,,10,65,344,14,12,25,095,36,25,28,134,,0*68');
INSERT INTO "public"."device_temp_data" VALUES (1934215274395987968, '2025-06-15 19:43:52.05592', 1, '$GPGSV,2,2,07,28,35,218,31,31,07,217,38,32,48,305,29,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1934215278988750848, '2025-06-15 19:43:53.148529', 1, '$BDGSV,1,1,03,19,30');
INSERT INTO "public"."device_temp_data" VALUES (1934215283535376384, '2025-06-15 19:43:54.234159', 1, '$GPGSV,2,2,07,28,35,218,33,31,07,217,38,32,455.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215288144916480, '2025-06-15 19:43:55.333708', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215292930617344, '2025-06-15 19:43:56.47463', 1, '$GNGGA,114356.000,3028.01211,N,10406.49967,E,1,08,1.3,586.7,M,-43.0,M,,*66');
INSERT INTO "public"."device_temp_data" VALUES (1934215297565323264, '2025-06-15 19:43:57.579741', 1, '$GNGLL,3028.01211,N,10406.49967,E,114356.000,A,A*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215302313275392, '2025-06-15 19:43:58.711037', 1, '$GNGSA,A,3,10,12,28,3.000,15,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934215306914426880, '2025-06-15 19:43:59.808677', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215311532355584, '2025-06-15 19:44:00.909956', 1, ',24,,,24,0*51');
INSERT INTO "public"."device_temp_data" VALUES (1934215316364193792, '2025-06-15 19:44:02.06107', 1, '$GPGSV,2,2,08,25,28,134,,28,35,218,32,31,07,217,39,32,48,305,29,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1934215320965345280, '2025-06-15 19:44:03.158392', 1, '$BDGSV,1,1,04,05,,,29,19,30,310,39,29,20,238,29,32,28,087,19,0*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215325591662592, '2025-06-15 19:44:04.261782', 1, '$GNRMC,114401.000,A,3028.01209,N,10406.49971,E,,29,19,30,310,39,29,20,238,29,32,28,087,19,0*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215330176036864, '2025-06-15 19:44:05.354172', 1, '$GNRMC,114402.000,$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215334768799744, '2025-06-15 19:44:06.449794', 1, '$GNGGA,114407.000,3028.01206,N,10406.49979,E,1,08,1.3,585.9,M,-43.0,M,,*61');
INSERT INTO "public"."device_temp_data" VALUES (1934215339386728448, '2025-06-15 19:44:07.550714', 1, '$GNGLL,3028.01206,N,10406.49979,E,114407.000,A,A*45');
INSERT INTO "public"."device_temp_data" VALUES (1934215344096931840, '2025-06-15 19:44:08.673477', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215348760997888, '2025-06-15 19:44:09.785417', 1, '$GNGSA,A,3,');
INSERT INTO "public"."device_temp_data" VALUES (1934215353500561408, '2025-06-15 19:44:10.915996', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215358286262272, '2025-06-15 19:44:12.056616', 1, '$GNGGA,114408.000,3028.01206,N,1GPGSV,2,2,08,25,28,133,,28,36,218,31,31,07,217,40,32,48,305,28,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1934215363004854272, '2025-06-15 19:44:13.181727', 1, '$BDGSV,1,1,04,05,,,26,19,31,310,39,29,19,238,31,32,28,087,20,0*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934215367639560192, '2025-06-15 19:44:14.286652', 1, '$GNRMC,114412.000,A,3028.01188,N,10406.49984,E,0.55,0.TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215372412678144, '2025-06-15 19:44:15.42409', 1, '$GNGGA,114416.000,3028.01194,N,10406.49990,E,1,08,1.3,586.5,M,-43.0,M,,*61');
INSERT INTO "public"."device_temp_data" VALUES (1934215377118687232, '2025-06-15 19:44:16.546725', 1, '$GNGLL,3028.01194,N,10406.49990,E,114416.000,A,A*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215381791141888, '2025-06-15 19:44:17.660386', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,114416.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215386576842752, '2025-06-15 19:44:18.80141', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215391362543616, '2025-06-15 19:44:19.942169', 1, '$10,38,29,19,238,30,32,28,087,19,0*47');
INSERT INTO "public"."device_temp_data" VALUES (1934215396106301440, '2025-06-15 19:44:21.073817', 1, '$GNRMC,114421.000,A,3028.01193,N,10406.49993,E,0.00,0.00,150625,,,A,V*02');
INSERT INTO "public"."device_temp_data" VALUES (1934215400736813056, '2025-06-15 19:44:22.177868', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215405463793664, '2025-06-15 19:44:23.304399', 1, '$GNZDA,114421.000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934215410236911616, '2025-06-15 19:44:24.442322', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215414921949184, '2025-06-15 19:44:25.559259', 1, '$GNGGA,114422.000,3028.01192,N,1040989,E,114428.000,A,A*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934215419770564608, '2025-06-15 19:44:26.715476', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215424455602176, '2025-06-15 19:44:27.832319', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215429157416960, '2025-06-15 19:44:28.95375', 1, '$GPGSV,2,1,08,02,08,320,,10,65,345,18,12,25,095,37,24,,,25,0*51');
INSERT INTO "public"."device_temp_data" VALUES (1934215433901174784, '2025-06-15 19:44:30.084257', 1, '$GPGSV,2,2,08,25,28,133,,28,36,218,32,31,07,218,38,32,48,305,29,0*61A');
INSERT INTO "public"."device_temp_data" VALUES (1934215438607183872, '2025-06-15 19:44:31.206042', 1, '$GNRMC,114430.000,A,3028.01191,N,10406.49988,E,0.00,0.00,150625,,,A,V*0A');
INSERT INTO "public"."device_temp_data" VALUES (1934215443300610048, '2025-06-15 19:44:32.325069', 1, '$GNV0*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934215447905955840, '2025-06-15 19:44:33.423901', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215452557438976, '2025-06-15 19:44:34.532167', 1, '$GNGGA,114433.000,3028.01193,N,10406.49988,E,1,08,1.3,587.0,M,-43.0,M,,*6C');
INSERT INTO "public"."device_temp_data" VALUES (1934215457204727808, '2025-06-15 19:44:35.640328', 1, '$GNGLL,3028.01193,N,10406.49988,E,114433.000,A,A*43');
INSERT INTO "public"."device_temp_data" VALUES (1934215461768130560, '2025-06-15 19:44:36.72849', 1, '$GNGSA,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215466440585216, '2025-06-15 19:44:37.842157', 1, '$GNGGA,114436.000,3028.01197,N,10406.49989,E,1,08,1.3,586.9,M,-43.0,M,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934215471247257600, '2025-06-15 19:44:38.988109', 1, '$GNGLL,3028.01197,N,10,33,31,08,218,39,32,48,305,30,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1934215476007792640, '2025-06-15 19:44:40.123641', 1, '$BDGSV,1,1,04,05,,,27,19,31,310,39,29,19,238,33,32,28,087,13,0*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934215480806076416, '2025-06-15 19:44:41.267867', 1, '$GNRMC,114439.000,A,3028.01205,N,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215485403033600, '2025-06-15 19:44:42.36378', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215490067099648, '2025-06-15 19:44:43.475479', 1, '$GNGGA,114443.000,3028.01215,N,10406.49993,E,1,08,1.3,586.0,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934215494781497344, '2025-06-15 19:44:44.598692', 1, '$GNGLL,3028.01215,N,10406.49993,E,114443.000,G,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215499349094400, '2025-06-15 19:44:45.688048', 1, '$GNZDA,114443.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215504076075008, '2025-06-15 19:44:46.815936', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215508899524608, '2025-06-15 19:44:47.96581', 1, '06.49994,E,114447.000,A,A*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934215513509064704, '2025-06-15 19:44:49.064323', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215518047301632, '2025-06-15 19:44:50.146737', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215522828808192, '2025-06-15 19:44:51.286324', 1, '$GPGSV,2,1,08,02,08,320,,A,3028.01220,N,10406.49994,E,0.00,0.00,150625,,,A,V*00');
INSERT INTO "public"."device_temp_data" VALUES (1934215527413182464, '2025-06-15 19:44:52.379874', 1, '$GNVTG,0.00,T,,M,0.00,N,0.K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215532190494720, '2025-06-15 19:44:53.518176', 1, '$GNZDA,114453.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215536795840512, '2025-06-15 19:44:54.616713', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215541380214784, '2025-06-15 19:44:55.709565', 1, '$GNGGA,114454.000,3028.01222,N,10406.49996,E,1,08,1.3,585.3,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215546014920704, '2025-06-15 19:44:56.814729', 1, '$GNGLL,3028.01222,N,1040GA,114455.000,3028.01222,N,10406.49996,E,1,08,1.3,585.2,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215550716735488, '2025-06-15 19:44:57.935836', 1, '$GNG305,28,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1934215555364024320, '2025-06-15 19:44:59.043486', 1, '$BDGSV,1,1,04,05,,,27,19,31,310,38,29,19,238,32,32,28,087,06,0*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215560019701760, '2025-06-15 19:45:00.153678', 1, '$GNRMC,114459.000,A,3028.01221,N,10406.49995,E,0.00,0.00,150625,,,A,V*01');
INSERT INTO "public"."device_temp_data" VALUES (1934215564629241856, '2025-06-15 19:45:01.252349', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215569293307904, '2025-06-15 19:45:02.363662', 1, '$GNZDA,114459.000,15,06,2025,,E,0.00,0.00,150625,,,A,V*0D');
INSERT INTO "public"."device_temp_data" VALUES (1934215574007705600, '2025-06-15 19:45:03.48804', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215578575302656, '2025-06-15 19:45:04.577859', 1, '$GNZDA04.000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215583298088960, '2025-06-15 19:45:05.703913', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215587995709440, '2025-06-15 19:45:06.823049', 1, '$GNGGA,114505.000,3028.01225,N,10406.49993,E,1,07,1.6,584.8,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934215592710107136, '2025-06-15 19:45:07.947372', 1, '$GNGLL,3028.01225,N,10406.49993,E,114505.000,A,N,10406.49993,E,1,07,1.6,584.8,M,-43.0,M,,*6E');
INSERT INTO "public"."device_temp_data" VALUES (1934215597458059264, '2025-06-15 19:45:09.079166', 1, '$GNGLL,3028.01225,N,10406.49993,E,114506.000,A,A*400.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215601992101888, '2025-06-15 19:45:10.160415', 1, '$GNZDA,114510.000,15,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215606643585024, '2025-06-15 19:45:11.269789', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215611248930816, '2025-06-15 19:45:12.367564', 1, '$GNGGA,114511.000,3028.01228,N,10406.49992,E,1,07,1.6,584.6,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215627489275904, '2025-06-15 19:45:16.239817', 1, '$GNGLL,3028.01228,N,10406.49992,A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215632094621696, '2025-06-15 19:45:17.337604', 1, '$GNGGA,114513.000,3028.01228,N,10406.49993,E,1,07,1.6,584.5,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215636637052928, '2025-06-15 19:45:18.42066', 1, '$GNGLL,3028.0994,E,114516.000,A,A*44');
INSERT INTO "public"."device_temp_data" VALUES (1934215641296924672, '2025-06-15 19:45:19.531499', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215645839355904, '2025-06-15 19:45:20.614793', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934215650516004864, '2025-06-15 19:45:21.729526', 1, '$GPGSV,3,1,09,02,09,320,,10,65,345,95,36,18,,,26,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1934215655175876608, '2025-06-15 19:45:22.840187', 1, '$GPGSV,3,2,09,24,,,23,25,28,133,24,28,36,218,33,31,08,218,38,0*5E');
INSERT INTO "public"."device_temp_data" VALUES (1934215659965771776, '2025-06-15 19:45:23.982909', 1, '$GPGSV,3,3,09,32,48,306,29');
INSERT INTO "public"."device_temp_data" VALUES (1934215664747278336, '2025-06-15 19:45:25.122469', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215669373595648, '2025-06-15 19:45:26.22514', 1, '$GNZDA,114521.000,15,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934215674016690176, '2025-06-15 19:45:27.332014', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215678726893568, '2025-06-15 19:45:28.455177', 1, '$GNGGA,114522.000,3028.01221,N,1M,-43.0,M,,*62');
INSERT INTO "public"."device_temp_data" VALUES (1934215683395153920, '2025-06-15 19:45:29.568627', 1, '$GNGLL,3028.01219,N,10406.49994,E,114526.000,A,A*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215688034054144, '2025-06-15 19:45:30.674874', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215692832337920, '2025-06-15 19:45:31.81843', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*309,02,09,320,,10,66,345,21,12,25,095,35,18,,,23,0*52');
INSERT INTO "public"."device_temp_data" VALUES (1934215697508986880, '2025-06-15 19:45:32.933022', 1, '$GPGSV,3,2,09,24,,,22,25,28,133,17,28,361,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215702055612416, '2025-06-15 19:45:34.017174', 1, '$GNGGA,114533.000,3028.01228,N,10406.49999,E,1,07,1.6,583.5,M,-43.0,M,,*65');
INSERT INTO "public"."device_temp_data" VALUES (1934215706639986688, '2025-06-15 19:45:35.110694', 1, '$GNGLL,3028.01228,N,10406.49999,E,114533.000,A,A*41');
INSERT INTO "public"."device_temp_data" VALUES (1934215711245332480, '2025-06-15 19:45:36.20864', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215715863261184, '2025-06-15 19:45:37.309724', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934215720422469632, '2025-06-15 19:45:38.396714', 1, '$GPGSV,3,1,09,02,09,320,,10,66,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215725057175552, '2025-06-15 19:45:39.501381', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934215729679298560, '2025-06-15 19:45:40.603609', 1, '$GPGSV,3,1,09,02,09,320,,10,66,345,23,12,25,095,36,18,,,20,0*50');
INSERT INTO "public"."device_temp_data" VALUES (1934215734246895616, '2025-06-15 19:45:41.692209', 1, '$GPGSV,3,2,09,24,,,22,25,28,133,22,28,36,218,34,31,08,218,37,0*51');
INSERT INTO "public"."device_temp_data" VALUES (1934215738961293312, '2025-06-15 19:45:42.816728', 1, '$GPGSV,3,3,09,32,48,306,28,0*5E');
INSERT INTO "public"."device_temp_data" VALUES (1934215743570833408, '2025-06-15 19:45:43.915762', 1, '$BDGSV8,19,31,311,38,29,19,238,29,32,28,087,,0*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215748146819072, '2025-06-15 19:45:45.00621', 1, '$GNRMC,114540.000,A,3028.01226,N,10406.49997,E,0.00,0.00,150625,,,A,V*0D');
INSERT INTO "public"."device_temp_data" VALUES (1934215752886382592, '2025-06-15 19:45:46.136717', 1, '$GNVTG,0.00,T,,M,0.00,N,14543.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215757521088512, '2025-06-15 19:45:47.241531', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215762122240000, '2025-06-15 19:45:48.338723', 1, '$GNGGA,114544.000,3028.01221,N,10406.49998,E,1,07,*68');
INSERT INTO "public"."device_temp_data" VALUES (1934215766740168704, '2025-06-15 19:45:49.439929', 1, '$GNGLL,3028.01217,N,10406.50000,E,114547.000,A,A*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215771370680320, '2025-06-15 19:45:50.543868', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215775980220416, '2025-06-15 19:45:51.642523', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934215780619120640, '2025-06-15 19:45:52.748491', 1, '$GPGSV,3,1,09,02,09,320,,10,66,345,20,12,25,094,35,18,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215785207689216, '2025-06-15 19:45:53.842694', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4,0.00,150625,,,A,V*02');
INSERT INTO "public"."device_temp_data" VALUES (1934215789930475520, '2025-06-15 19:45:54.968153', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215794552598528, '2025-06-15 19:45:56.070184', 1, '$GNZDA,114552.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215799099224064, '2025-06-15 19:45:57.154176', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215803708764160, '2025-06-15 19:45:58.25389', 1, '$GNGGA,114553.000,3028.01213,N,10406.50003,E,1,07,1.6,582.5,M53.000,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934215808288944128, '2025-06-15 19:45:59.345529', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215812969787392, '2025-06-15 19:46:00.461391', 1, ',N,10406.50004,E,1,07,1.6,582.2,M,-43.0,M,,*60');
INSERT INTO "public"."device_temp_data" VALUES (1934215817650630656, '2025-06-15 19:46:01.57769', 1, '$GNGLL,3028.01210,N,10406.50004,E,114558.000,A,A*42');
INSERT INTO "public"."device_temp_data" VALUES (1934215822184673280, '2025-06-15 19:46:02.658388', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215826810990592, '2025-06-15 19:46:03.761669', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*3450005,E,114559.000,A,A*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215831340838912, '2025-06-15 19:46:04.841437', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,3.2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215835941990400, '2025-06-15 19:46:05.938737', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2..00,0.00,150625,,,A,V*00');
INSERT INTO "public"."device_temp_data" VALUES (1934215840647999488, '2025-06-15 19:46:07.060125', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215845236568064, '2025-06-15 19:46:08.154506', 1, '$GNZDA,114603.000,15,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934215849950965760, '2025-06-15 19:46:09.27806', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215854493396992, '2025-06-15 19:46:10.361114', 1, '$GNGGA,V*01');
INSERT INTO "public"."device_temp_data" VALUES (1934215859090354176, '2025-06-15 19:46:11.457901', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215863653756928, '2025-06-15 19:46:12.545971', 1, '$GNZDA,114604.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934215868464623616, '2025-06-15 19:46:13.692421', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215873069969408, '2025-06-15 19:46:14.790391', 1, '2,1.6,2.7,1*39');
INSERT INTO "public"."device_temp_data" VALUES (1934215877713063936, '2025-06-15 19:46:15.897768', 1, '$GNGSA,A,3,19,29,,,,,,,,,,,3.2,1.6,2.7,4*34');
INSERT INTO "public"."device_temp_data" VALUES (1934215882318409728, '2025-06-15 19:46:16.995064', 1, '$GPGSV,3,1,09,02,09,320,,10,66,345,22,12,25,094,34,18,,,11,0*50');
INSERT INTO "public"."device_temp_data" VALUES (1934215887062167552, '2025-06-15 19:46:18.12623', 1, '$GPGSV,3,2,09,243,16,28,36,219,33,31,08,218,37,0*53');
INSERT INTO "public"."device_temp_data" VALUES (1934215891763982336, '2025-06-15 19:46:19.247321', 1, '$GPGSV,3,3,09,32,48,306,31,0*56');
INSERT INTO "public"."device_temp_data" VALUES (1934215896411271168, '2025-06-15 19:46:20.355893', 1, '$BDGSV,1,1,04,05,,,27,19,31,311,14617.000,15,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934215901058560000, '2025-06-15 19:46:21.463311', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215905714237440, '2025-06-15 19:46:22.573065', 1, '$GNGGA,114618.000,3028.01206,N,10406.50008,E,1,08,1.3,581.0,M,-43.0,M,,*67');
INSERT INTO "public"."device_temp_data" VALUES (1934215910541881344, '2025-06-15 19:46:23.724876', 1, '$GNGLL,3028.012N,10406.50008,E,114619.000,A,A*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934215915260473344, '2025-06-15 19:46:24.849762', 1, '$GNGSA,A625,,,A,V*04');
INSERT INTO "public"."device_temp_data" VALUES (1934215919991648256, '2025-06-15 19:46:25.977538', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934215924768960512, '2025-06-15 19:46:27.116584', 1, '$GNZDA,114623.000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934215929458192384, '2025-06-15 19:46:28.234476', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934215934394888192, '2025-06-15 19:46:29.411907', 1, '$GNGGA,114624.000,3028.01197,N,10406.50006,E,1,08,1.3,581.2,M,-43.0,M,,*6F');
INSERT INTO "public"."device_temp_data" VALUES (1934215939541299200, '2025-06-15 19:46:30.638965', 1, '$GNGLL,3028.01197,N,1');
INSERT INTO "public"."device_temp_data" VALUES (1934215944209559552, '2025-06-15 19:46:31.751119', 1, '$GNGGA,114625.000,3028.01195,N,104028,36,219,33,31,08,218,37,32,48,306,31,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215949179809792, '2025-06-15 19:46:32.936657', 1, '$BDGSV,1,1,04,05,,,27,19,31,311,37,29,19,238,33,32,27,088,18,0*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934215953806127104, '2025-06-15 19:46:34.039602', 1, '$GNRMC,114630.000,A,3028.01188,N,10406.50001,E,0.00,0.00,150625,,,A,V*00');
INSERT INTO "public"."device_temp_data" VALUES (1934215958851874816, '2025-06-15 19:46:35.242916', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*230,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934215963520135168, '2025-06-15 19:46:36.355977', 1, '$GPTXT,01,01,01,ANTENNA O.000,A,A*47');
INSERT INTO "public"."device_temp_data" VALUES (1934215968213561344, '2025-06-15 19:46:37.474738', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934215972869238784, '2025-06-15 19:46:38.584037', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934215977701076992, '2025-06-15 19:46:39.736184', 1, '$GPGSV,2,1,08,02,09,320,,10,66,345,22,12,25,094,34,24,,,22,0*5F');
INSERT INTO "public"."device_temp_data" VALUES (1934215983006871552, '2025-06-15 19:46:41.001852', 1, '$GPGSV,2,2,08,25,29,133,16,28,37,219,33,31,08,218,38,32,48,306,29,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934215987637383168, '2025-06-15 19:46:42.105071', 1, '$BDGSV,1RMC,114638.000,A,3028.01192,N,10406.50001,E,0.00,0.00,150625,,,A,V*03');
INSERT INTO "public"."device_temp_data" VALUES (1934215992787988480, '2025-06-15 19:46:43.333277', 1, '$GNVTG,0.00,T,,M$GNGGA,114642.000,3028.01194,N,10406.50004,E,1,08,1.3,581.1,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934215997435277312, '2025-06-15 19:46:44.441378', 1, '$GNGLL,3028.01194,N,10406.50004,E,114642.000,A,A*45');
INSERT INTO "public"."device_temp_data" VALUES (1934216002166452224, '2025-06-15 19:46:45.569257', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3000,15,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934216007069593600, '2025-06-15 19:46:46.738588', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216011838517248, '2025-06-15 19:46:47.875696', 1, '$GNGGA,114643.000,3028.01195,N,10406.50005,E,1,08,1.3,581.1,M,-43.19,31,311,37,29,19,237,33,32,27,088,22,0*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934216016502583296, '2025-06-15 19:46:48.98735', 1, '$GNRMC,114645.000,A,3028.01197,N,10406.50007,E,0.00,0.00,150625,,,A,V*0A');
INSERT INTO "public"."device_temp_data" VALUES (1934216021372170240, '2025-06-15 19:46:50.148362', 1, '$GNVTG,0.00,T');
INSERT INTO "public"."device_temp_data" VALUES (1934216026237562880, '2025-06-15 19:46:51.308727', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216030922600448, '2025-06-15 19:46:52.425123', 1, '$GNGGA,114648.000,3028.01200,N,10406.50008,E,1,08,1.3,581.1,M,-43.0,M,,*65');
INSERT INTO "public"."device_temp_data" VALUES (1934216035968348160, '2025-06-15 19:46:53.628688', 1, '$GNGLL,3028.01200,N,10406.50008,E,114648.00*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216040905043968, '2025-06-15 19:46:54.805813', 1, '$GNZDA,114649.000,15,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216045711716352, '2025-06-15 19:46:55.951961', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216050459668480, '2025-06-15 19:46:57.083183', 1, '$GNGGA,114650.000,3028.01225,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934216055568330752, '2025-06-15 19:46:58.301264', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216060156899328, '2025-06-15 19:46:59.395244', 1, '$GNGGA,114656.000,3028.01209,N,10406.50010,E,1,08,1.3,581.1,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934216064837742592, '2025-06-15 19:47:00.511825', 1, '$GNGLL,3028.01209,N,10406.50010,E,114656.000,A,A*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216069464059904, '2025-06-15 19:47:01.614214', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216074228789248, '2025-06-15 19:47:02.750913', 1, '$GNGS0,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934216078968352768, '2025-06-15 19:47:03.880837', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216084064432128, '2025-06-15 19:47:05.095034', 1, '$GNZDA,114702.000,15,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934216088824967168, '2025-06-15 19:47:06.230258', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216093551947776, '2025-06-15 19:47:07.357857', 1, '$GNGGA,114703.000,3028.01216,N,10406.50013,E,1,08,1.3,581.0,M,-43.0,M,,*67');
INSERT INTO "public"."device_temp_data" VALUES (1934216098387980288, '2025-06-15 19:47:08.510389', 1, '$GNGLL,3028.01216,N,10406.50013,E,114703.000,A,A*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934216103278538752, '2025-06-15 19:47:09.676072', 1, '$GNGSA,A,3,10,.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216108152320000, '2025-06-15 19:47:10.838772', 1, '$GNZDA,114703.000,15,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934216112942215168, '2025-06-15 19:47:11.980256', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216117962797056, '2025-06-15 19:47:13.177917', 1, '2,27,088,24,0*43');
INSERT INTO "public"."device_temp_data" VALUES (1934216123197288448, '2025-06-15 19:47:14.425701', 1, '$GNRMC,114709.000,A,3028.01222,N,10406.50012,E,0.00,0.00,150625,,,A,V*0A');
INSERT INTO "public"."device_temp_data" VALUES (1934216128087846912, '2025-06-15 19:47:15.591205', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216132919685120, '2025-06-15 19:47:16.743965', 1, '$GNZDA,114709.000,15,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1934216137873158144, '2025-06-15 19:47:17.924771', 1, '$GPTX150625,,,A,V*04');
INSERT INTO "public"."device_temp_data" VALUES (1934216142730162176, '2025-06-15 19:47:19.082333', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216147499085824, '2025-06-15 19:47:20.219821', 1, '$GNZDA,114710.000,15,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934216152314146816, '2025-06-15 19:47:21.367383', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216157628329984, '2025-06-15 19:47:22.634612', 1, ',00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934216163261280256, '2025-06-15 19:47:23.977488', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216168554491904, '2025-06-15 19:47:25.239737', 1, '$GNGGA,114718.000,3028.01234,N,10406.50010,E,1,08,1.3,580.2,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934216173537325056, '2025-06-15 19:47:26.42654', 1, '$GNGLL,3028.01PEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216178515963904, '2025-06-15 19:47:27.61438', 1, '$GNGGA,114719.50008,E,114726.000,A,A*46');
INSERT INTO "public"."device_temp_data" VALUES (1934216183775621120, '2025-06-15 19:47:28.86835', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216188750065664, '2025-06-15 19:47:30.054754', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216193892282368, '2025-06-15 19:47:31.280857', 1, '$GPGSV,2,1,08,02,09,320,,10,66,346,26,12,25,094,34,24,,,23,0*59');
INSERT INTO "public"."device_temp_data" VALUES (1934216199059664896, '2025-06-15 19:47:32.51274', 1, '$GPGSV,2,2,08,25,29,132,20,28,37,219,34,31,09,218,38,4,05,,,28,19,31,311,37,29,19,,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216204210270208, '2025-06-15 19:47:33.740717', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216208941445120, '2025-06-15 19:47:34.868777', 1, '$GPGSV,2,1,08,02,09,319,,10,66,346,26,12,25,094,34,24,,,23,0*53');
INSERT INTO "public"."device_temp_data" VALUES (1934216213836197888, '2025-06-15 19:47:36.035245', 1, '$GPGSV,2,2,08,25,29,132,18,28,37,219,33,31,09,218,38,32,48,307,29,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1934216218701590528, '2025-06-15 19:47:37.195745', 1, '$BDGSV,1,1,04,05,,,28,19,31,311,36,29,19,237,35,3 OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216223705395200, '2025-06-15 19:47:38.388592', 1, '$GNGGA,114735.000,3028.01262,N,10406.50006,E,1,08,1.3,579.4,M,-43.0,M,,*66');
INSERT INTO "public"."device_temp_data" VALUES (1934216228574982144, '2025-06-15 19:47:39.549292', 1, '$GNGL000,3028.01264,N,10406.50005,E,1,08,1.3,579.3,M,-43.0,M,,*66');
INSERT INTO "public"."device_temp_data" VALUES (1934216234094686208, '2025-06-15 19:47:40.865057', 1, '$GNGLL,3028.01264,N,10406.50005,E,114737.000,A,A*4B');
INSERT INTO "public"."device_temp_data" VALUES (1934216239081713664, '2025-06-15 19:47:42.054948', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*3702,09,319,,10,66,346,25,12,25,094,35,24,,,24,0*56');
INSERT INTO "public"."device_temp_data" VALUES (1934216243754168320, '2025-06-15 19:47:43.168524', 1, '$GPGSV,2,2,08,25,29,132,18,28,37,219,34,31,09,218,37,32,48,$GNZDA,114741.000,15,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1934216248766361600, '2025-06-15 19:47:44.363019', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216253954715648, '2025-06-15 19:47:45.600544', 1, '$GNGGA,114742.000,3028.01271,N,10406.50005,E,1,08,1.3,579.1,M,-43.0,M,,*62A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216259176624128, '2025-06-15 19:47:46.845808', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216264130097152, '2025-06-15 19:47:48.026155', 1, '$GPGSV,2,1,08,02,09,319,,10,67,346,25,12,25,093,35,24,,,23,0*57');
INSERT INTO "public"."device_temp_data" VALUES (1934216269859516416, '2025-06-15 19:47:49.392039', 1, '$GPGSV,2,2,08,25,29,132,18,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216274682966016, '2025-06-15 19:47:50.542134', 1, '$GPGSV,2,1,08,02,09,319,,10,67,346,25,12,25,093,35,24,,,23,0*57');
INSERT INTO "public"."device_temp_data" VALUES (1934216281070891008, '2025-06-15 19:47:52.065691', 1, '$GPGSV,2,2,08,25,29,132,18,28,37,219,3748.000,15,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216285995003904, '2025-06-15 19:47:53.239544', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216291825086464, '2025-06-15 19:47:54.629047', 1, '$GNGGA,114749.000,3028.01281,N,10406.50005,E,1,08,1.3,578.8,M,-43.0,M,,*6E');
INSERT INTO "public"."device_temp_data" VALUES (1934216296879222784, '2025-06-15 19:47:55.834751', 1, '$GNGLL,30237,35,32,27,088,25,0*43');
INSERT INTO "public"."device_temp_data" VALUES (1934216302126297088, '2025-06-15 19:47:57.085443', 1, '$GNRMC,114751.000,A,3028.01284,N,10406.50004,E,0.00,0.00,15062150625,,,A,V*02');
INSERT INTO "public"."device_temp_data" VALUES (1934216306786168832, '2025-06-15 19:47:58.196045', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216311735447552, '2025-06-15 19:47:59.376836', 1, '$GNZDA,114755.000,15,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1934216316986716160, '2025-06-15 19:48:00.628581', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216321889857536, '2025-06-15 19:48:01.797869', 1, '$GNGGA,114756.000,3028.01291,N,10406.50003,E15,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934216326755250176, '2025-06-15 19:48:02.957919', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216331771637760, '2025-06-15 19:48:04.153867', 1, '$GNGGA,114757.000,15,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1934216336959991808, '2025-06-15 19:48:05.390869', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216341959602176, '2025-06-15 19:48:06.582806', 1, '$GNGGA,114803.000,3028.01300,N,10406.50007,E,1,08,1.3,578.4,M,-43.0,M,,*69');
INSERT INTO "public"."device_temp_data" VALUES (1934216346892103680, '2025-06-15 19:48:07.758077', 1, '$GNGLL,3028.01300,N,10406.50007,E,114803.000,A,A*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216351862353920, '2025-06-15 19:48:08.943582', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216357101039616, '2025-06-15 19:48:10.192465', 1, '$GNGS0,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216361828020224, '2025-06-15 19:48:11.319134', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216366928293888, '2025-06-15 19:48:12.535463', 1, '$GNZDA,114809.000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934216372338946048, '2025-06-15 19:48:13.825128', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216377212727296, '2025-06-15 19:48:14.987934', 1, '$GNGGA,114810.000,3028.01303,N,10406.50003,E,1,08,1.3,578.2,M,-43.0,M,,*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934216382237503488, '2025-06-15 19:48:16.185269', 1, '$GNGLL,3028.01303,N,10406.50003,E,114810.000,A,A*47');
INSERT INTO "public"."device_temp_data" VALUES (1934216387522326528, '2025-06-15 19:48:17.445994', 1, '$GNGSA,A,3,10,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216392702291968, '2025-06-15 19:48:18.680724', 1, '$GNGSA,A,000,A,A*41');
INSERT INTO "public"."device_temp_data" VALUES (1934216398167470080, '2025-06-15 19:48:19.983971', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216403066417152, '2025-06-15 19:48:21.151531', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216408003112960, '2025-06-15 19:48:22.328622', 1, '$GPGSV,2,1,08,02,09,319,,10,67,346,26,12,25,093,34,24,,,24,0*52');
INSERT INTO "public"."device_temp_data" VALUES (1934216413145329664, '2025-06-15 19:48:23.554815', 1, '$GPGSV,2,2,08,25,29,132,20,28,37,219,31,31,09,218,37,32,48,307,32,02,311,36,29,18,237,35,32NGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216418455318528, '2025-06-15 19:48:24.820167', 1, '$GPGSV,2,1,08,02,09,319,,10,67,346,26,12,25,093,34,24,,,24,0*52');
INSERT INTO "public"."device_temp_data" VALUES (1934216423194882048, '2025-06-15 19:48:25.950344', 1, '$GPGSV,2,2,08,25,29,132,20,28,37,219,31,31,09,218,37,32,48,307,31,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1934216428240629760, '2025-06-15 19:48:27.153999', 1, '$BDGSV,1,1,04,05,,,28,19,32,311,36,29,18,237,36,32,27,088,28,0*405,N,10406.49998,E,0.00,0.00,150625,,,A,V*0D');
INSERT INTO "public"."device_temp_data" VALUES (1934216433357680640, '2025-06-15 19:48:28.373399', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216438256627712, '2025-06-15 19:48:29.541589', 1, '$GNZDA,114824.000,15,06,2025,00,0VTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216443000385536, '2025-06-15 19:48:30.672532', 1, '$GNZDA,114826.000,15,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1934216447723171840, '2025-06-15 19:48:31.798465', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216452798279680, '2025-06-15 19:48:33.008016', 1, '$GNGGA,114827.000,3028.01307,N,104ZDA,114831.000,15,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1934216457848221696, '2025-06-15 19:48:34.212969', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216462579396608, '2025-06-15 19:48:35.340474', 1, '$GNGGA,114832.000,3028.01309,N,10406.49993,E,1,08,1.3,577.8,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934216467750973440, '2025-06-15 19:48:36.573843', 1, '$GNGLL,3028.01309,N,10406.49993,E,114832.000,A,A*45');
INSERT INTO "public"."device_temp_data" VALUES (1934216473216151552, '2025-06-15 19:48:37.876513', 1, '$GNGSA,A,3,10,12,28,31,32');
INSERT INTO "public"."device_temp_data" VALUES (1934216478421282816, '2025-06-15 19:48:39.117308', 1, '$GNZDA,114832.000,15,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216483324424192, '2025-06-15 19:48:40.286472', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216488445669376, '2025-06-15 19:48:41.507189', 1, ',0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216493348810752, '2025-06-15 19:48:42.676069', 1, '$GNZDA,114837.000,15,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1934216498407141376, '2025-06-15 19:48:43.882765', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216503566135296, '2025-06-15 19:48:45.112403', 1, '$GNGGA,114838.000,3028.01307,N,10406.49989,E,1,08,1.3,577.7,M,-43.0,M,,*6D');
INSERT INTO "public"."device_temp_data" VALUES (1934216508720934912, '2025-06-15 19:48:46.341507', 1, '$GNGLANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216513678602240, '2025-06-15 19:48:47.523624', 1, '$GNGGA,114839.0846.000,3028.01310,N,10406.49984,E,1,08,1.3,577.6,M,-43.0,M,,*6E');
INSERT INTO "public"."device_temp_data" VALUES (1934216518548189184, '2025-06-15 19:48:48.68489', 1, '$GNGLL,3028.01310,N,10406.49984,E,114846.000,A,A*48');
INSERT INTO "public"."device_temp_data" VALUES (1934216523270975488, '2025-06-15 19:48:49.810754', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216528484495360, '2025-06-15 19:48:51.053773', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216533832232960, '2025-06-15 19:48:52.328719', 1, '$GPGSV,3,1,09,02,09,319,,10,67,346,27,12,26,093,33,18,19,179,,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1934216539163193344, '2025-06-15 19:48:53.599554', 1, '$GPGSV,3,2,09,24,,,21,25,29,14851.000,15,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1934216544301215744, '2025-06-15 19:48:54.824101', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216549418266624, '2025-06-15 19:48:56.044106', 1, '$GNGGA,114852.000,3028.01319,N,10406.49980,E,1,08,1.3,577.3,M,-43.0,M,,*63');
INSERT INTO "public"."device_temp_data" VALUES (1934216554673729536, '2025-06-15 19:48:57.297345', 1, '$GNGLL,3028.01319,N,10406.49980,E,114852.000,A,A*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216559664951296, '2025-06-15 19:48:58.487996', 1, '$GNGSA625,,,A,V*06');
INSERT INTO "public"."device_temp_data" VALUES (1934216564551315456, '2025-06-15 19:48:59.652998', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216569517371392, '2025-06-15 19:49:00.836843', 1, '$GNZDA,114855.000,15,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1934216574298877952, '2025-06-15 19:49:01.975126', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216579332042752, '2025-06-15 19:49:03.176959', 1, '$GNGGA,114856.000,3028.01322,N,10406.49982.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216584742694912, '2025-06-15 19:49:04.466709', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216590123986944, '2025-06-15 19:49:05.749521', 1, '$GPGSV,3,1,09,02,09,319,,10,67,347,27,12,26,093,33,18,19,10.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216595316535296, '2025-06-15 19:49:06.987292', 1, '$GNZDA,114902.000,15,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216600358088704, '2025-06-15 19:49:08.188592', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216605680660480, '2025-06-15 19:49:09.458975', 1, '$GNGGA,114903.000,3028.01325,N,10406.49935,29,18,237,35,32,27,089,28,0*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216610655105024, '2025-06-15 19:49:10.644615', 1, '$GNRMC,114905.000,A,3028.01325,N,10406.49983,E,0.00,0.00NGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216615612772352, '2025-06-15 19:49:11.826423', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216620557856768, '2025-06-15 19:49:13.00526', 1, '$GPGSV,3,1,09,02,10,319,,10,67,347,28,12,26,093,33,18,19,179,,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1934216625767182336, '2025-06-15 19:49:14.247157', 1, '$GPGS,29,18,237,36,32,27,089,29,0*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216631064588288, '2025-06-15 19:49:15.51011', 1, '$GNRMC,114910.000,A,3028.01327,N,10406.49981,E,0.00,0.$GNGGA,114914.000,3028.01331,N,10406.49978,E,1,08,1.3,576.7,M,-43.0,M,,*68');
INSERT INTO "public"."device_temp_data" VALUES (1934216635846094848, '2025-06-15 19:49:16.65092', 1, '$GNGLL,3028.01331,N,10406.49978,E,114914.000,A,A*4E');
INSERT INTO "public"."device_temp_data" VALUES (1934216640602435584, '2025-06-15 19:49:17.784135', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216646310883328, '2025-06-15 19:49:19.145891', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216651218219008, '2025-06-15 19:49:20.315789', 1, '$GPGSV,3,1,09,02,10,319,,10,6');
INSERT INTO "public"."device_temp_data" VALUES (1934216656406573056, '2025-06-15 19:49:21.552716', 1, '$GNGGA,114920.000,3028.01336,N,10406.49975,E,1,08,1.3,576.6,M,-43.0,M,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934216661829808128, '2025-06-15 19:49:22.845223', 1, '$GNGLL,3028.01336,N,10406.49975,E,114920.000,A,A*43');
INSERT INTO "public"."device_temp_data" VALUES (1934216666720366592, '2025-06-15 19:49:24.011159', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216672269430784, '2025-06-15 19:49:25.334691', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216677105463296, '2025-06-15 19:49:26.487338', 1, '$GPGSV,3,1,09,02,10,319,,100,0.00,150625,,,A,V*06');
INSERT INTO "public"."device_temp_data" VALUES (1934216682172182528, '2025-06-15 19:49:27.695757', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216686873997312, '2025-06-15 19:49:28.816211', 1, '$GNZDA,114922.000,15,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216691877801984, '2025-06-15 19:49:30.009053', 1, '$GPTXT,01,01,01,ANTENNA19,,10,67,347,29,12,26,093,33,18,19,179,,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1934216697204568064, '2025-06-15 19:49:31.27949', 1, '$GPGSV,3,2,09,24,,,21,25,29,132,26,28,38,220,33,31,09,218,38,0*5A');
INSERT INTO "public"."device_temp_data" VALUES (1934216702191595520, '2025-06-15 19:49:32.468132', 1, '$GPGSV,3,3,09,32,49N*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216707472224256, '2025-06-15 19:49:33.727008', 1, '$GNGGA,114931.000,3028.01344,N,10406.49973,E,1,08,1.3,576.4,M,-43.0,M,,*65');
INSERT INTO "public"."device_temp_data" VALUES (1934216712291479552, '2025-06-15 19:49:34.876457', 1, '$GNGLL,3028.01344,N,10406.49973,E,114931.000,A,A*40');
INSERT INTO "public"."device_temp_data" VALUES (1934216717869903872, '2025-06-15 19:49:36.206302', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216722512998400, '2025-06-15 19:49:37.313929', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216727336448000, '2025-06-15 19:49:38.463361', 1, '$GPGSV,3,1,09,02,10,319,,10,67,347,28,12,26,093,34,18,19,179,,0*68');
INSERT INTO "public"."device_temp_data" VALUES (1934216732424138752, '2025-06-15 19:49:39.676264', 1, '$GPGSV,3,2,09,24,,,22,25,30,131,25,28,38,220,27,31,09,218,37,0*5B');
INSERT INTO "public"."device_temp_data" VALUES (1934216737595715584, '2025-06-15 19:49:40.909752', 1, '$GPGSV,3,3,09,32,49,308,30,0*58');
INSERT INTO "public"."device_temp_data" VALUES (1934216743169945600, '2025-06-15 19:49:42.238196', 1, '$BDGSV,1,1,04,05,,,27,19,32,312,35,29,18,237,37,32,27,089,29,0*41');
INSERT INTO "public"."device_temp_data" VALUES (1934216748706426880, '2025-06-15 19:49:43.558401', 1, '$GNRMC,114938.000,A,3028.01350,N,10406.49971,E,0.00,0.00,150625,,,A,V*06');
INSERT INTO "public"."device_temp_data" VALUES (1934216754368737280, '2025-06-15 19:49:44.908143', 1, '$GNVTG,0.00,T,,M,1.3,2.6,1*37');
INSERT INTO "public"."device_temp_data" VALUES (1934216759485788160, '2025-06-15 19:49:46.128464', 1, '$GNGSA,A,3,19,29,32,,,,,,,,,,2.9,1.3,2.6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216765089378304, '2025-06-15 19:49:47.464368', 1, '$GPGSV,3,1,09,02,10,319,,10,67,347,28,12,26,093,33,18,19,179,,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1934216770479058944, '2025-06-15 19:49:48.749201', 1, '$GPGSV,3,2,09,24,,,22,25,30,131,23,28,38,220,31,31,09,218,36,0*5B');
INSERT INTO "public"."device_temp_data" VALUES (1934216775155707904, '2025-06-15 19:49:49.864174', 1, '$GPGSV,3,3,09NA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216780822212608, '2025-06-15 19:49:51.215139', 1, '$GNGGA,114946.000,3028.01356,N,10406.49965,E,1,08,1.3,576.0,M,-43.0,M,,*0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216785758908416, '2025-06-15 19:49:52.392441', 1, '$GNZDA,114949.000,15,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934216791131811840, '2025-06-15 19:49:53.673363', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216796043341824, '2025-06-15 19:49:54.844926', 1, '$GNGGA,114950.000,3028.01358,N,10406.49963,E,1,08,1.3,575.9,M,-43.0,M,,*60');
INSERT INTO "public"."device_temp_data" VALUES (1934216800761933824, '2025-06-15 19:49:55.969791', 1, '$GNGLL,3028*5A');
INSERT INTO "public"."device_temp_data" VALUES (1934216805937704960, '2025-06-15 19:49:57.203803', 1, '$BDGSV,2,1,05,05,,,27,09,,,28,19,32,312,35,29,18,236,36,0*7E');
INSERT INTO "public"."device_temp_data" VALUES (1934216811516129280, '2025-06-15 19:49:58.533973', 1, '$BDGSV,2,2,05,32,27,089,29,0*4F');
INSERT INTO "public"."device_temp_data" VALUES (1934216817476235264, '2025-06-15 19:49:59.954483', 1, '$GNRMC,114953.000,A,3028.01359,N,10406.49962,E,0.00,0.00,150625,,,A,V*00*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216822870110208, '2025-06-15 19:50:01.240181', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216828071047168, '2025-06-15 19:50:02.480553', 1, '$GNGGA,114956.000,3028.01361,N,10406.49961,E,1M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216833620111360, '2025-06-15 19:50:03.803079', 1, '$GNZDA,115000.000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1934216839311781888, '2025-06-15 19:50:05.160965', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216845775204352, '2025-06-15 19:50:06.70149', 1, '$GNGGA,115001.000,3028.01364,N,10406.49959,E,1,08,1.3,575.6,M,-43.0,M,,*65');
INSERT INTO "public"."device_temp_data" VALUES (1934216850602848256, '2025-06-15 19:50:07.85276', 1, '$GNGLL,3028.01364,N,10406.49959,E,115001..6,4*3B');
INSERT INTO "public"."device_temp_data" VALUES (1934216856021889024, '2025-06-15 19:50:09.14418', 1, '$GPGSV,3,1,09,02,10,319,,10,68,347,200,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1934216860920836096, '2025-06-15 19:50:10.312942', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216865861726208, '2025-06-15 19:50:11.490783', 1, '$GNGGA,115008.000,3028.01369,N,10406.49959,E,1,08,1.3,575.5,M,-43.0,M,,*62');
INSERT INTO "public"."device_temp_data" VALUES (1934216871565979648, '2025-06-15 19:50:12.850453', 1, '$GNGLL,3028.01369,N,10406.49959,E,115008.000,A,A*45');
INSERT INTO "public"."device_temp_data" VALUES (1934216877026963456, '2025-06-15 19:50:14.152248', 1, '$GNGSA,A,3,10,12,28,31,32,,,,,,,,2.9,1.3,2.6,1*,,A,V*0D');
INSERT INTO "public"."device_temp_data" VALUES (1934216882706051072, '2025-06-15 19:50:15.506286', 1, '$GNVTG,0.00,T,,M,0.00,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216887948931072, '2025-06-15 19:50:16.756546', 1, '$GNZDA,115008.000,15,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1934216893472829440, '2025-06-15 19:50:18.073669', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216898879287296, '2025-06-15 19:50:19.362415', 1, '0,15,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1934216904038281216, '2025-06-15 19:50:20.592169', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1934216908803010560, '2025-06-15 19:50:21.72894', 1, '$GNGGA,115014.000,3028.01374,N,10406.49958,E,1,08,1.3,575.3,M,-43.0,M,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1934216913475465216, '2025-06-15 19:50:22.841735', 1, '$GNGLL1,09,1.0,575.3,M,-43.0,M,,*67');
INSERT INTO "public"."device_temp_data" VALUES (1934216918173085696, '2025-06-15 19:50:23.962306', 1, '$GNGLL,3028.01374,N,10406.49958,E,115015.000,A,A*44');
INSERT INTO "public"."device_temp_data" VALUES (1934216922912649216, '2025-06-15 19:50:25.092318', 1, '$GNGSA,N,0.00,K,A*23');
INSERT INTO "public"."device_temp_data" VALUES (1934216927476051968, '2025-06-15 19:50:26.180125', 1, '$GNZDA,115022.000,15,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936345254592532480, '2025-06-21 16:47:38.833357', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345259923492864, '2025-06-21 16:47:40.178057', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345264608530432, '2025-06-21 16:47:41.294015', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345269247430656, '2025-06-21 16:47:42.401119', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345273789861888, '2025-06-21 16:47:43.484503', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345278349070336, '2025-06-21 16:47:44.57117', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345282912473088, '2025-06-21 16:47:45.659794', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345287719145472, '2025-06-21 16:47:46.805784', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345292341268480, '2025-06-21 16:47:47.907173', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345296959197184, '2025-06-21 16:47:49.008804', 1, '$GNGGA,,,,,,C,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345301577125888, '2025-06-21 16:47:50.109856', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345306136334336, '2025-06-21 16:47:51.196934', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345310733291520, '2025-06-21 16:47:52.292256', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345315351220224, '2025-06-21 16:47:53.393037', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345319931400192, '2025-06-21 16:47:54.485882', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345324528357376, '2025-06-21 16:47:55.581492', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345329074982912, '2025-06-21 16:47:56.665411', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345333780992000, '2025-06-21 16:47:57.787136', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345339120340992, '2025-06-21 16:47:59.060304', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345344115757056, '2025-06-21 16:48:00.25177', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345349387997184, '2025-06-21 16:48:01.507765', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345354362441728, '2025-06-21 16:48:02.694793', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345369164140544, '2025-06-21 16:48:06.22374', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345379750563840, '2025-06-21 16:48:08.747287', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345385232519168, '2025-06-21 16:48:10.054738', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345391070990336, '2025-06-21 16:48:11.446855', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345396645220352, '2025-06-21 16:48:12.775541', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345402286559232, '2025-06-21 16:48:14.120137', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,NVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345407613325312, '2025-06-21 16:48:15.390812', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345413003005952, '2025-06-21 16:48:16.675032', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345418753396736, '2025-06-21 16:48:18.046134', 1, ',,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345424428290048, '2025-06-21 16:48:19.399599', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345429629227008, '2025-06-21 16:48:20.639957', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345435283148800, '2025-06-21 16:48:21.987023', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345440991596544, '2025-06-21 16:48:23.34821', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345445856989184, '2025-06-21 16:48:24.50831', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345451796123648, '2025-06-21 16:48:25.923966', 1, '$GPGSV,1,1,00,07');
INSERT INTO "public"."device_temp_data" VALUES (1936345457882058752, '2025-06-21 16:48:27.375939', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345463611478016, '2025-06-21 16:48:28.741445', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345468682391552, '2025-06-21 16:48:29.950302', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345474210484224, '2025-06-21 16:48:31.268352', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345480682295296, '2025-06-21 16:48:32.811423', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345487267352576, '2025-06-21 16:48:34.381045', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345494850654208, '2025-06-21 16:48:36.189844', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345502299738112, '2025-06-21 16:48:37.965333', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345510126309376, '2025-06-21 16:48:39.831577', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345516044472320, '2025-06-21 16:48:41.242783', 1, '$GNGLL,,,,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345525645234176, '2025-06-21 16:48:43.531532', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345533559885824, '2025-06-21 16:48:45.418684', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345543777210368, '2025-06-21 16:48:47.853187', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345551847051264, '2025-06-21 16:48:49.77829', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345560021749760, '2025-06-21 16:48:51.727494', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345567563108352, '2025-06-21 16:48:53.525336', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345577952399360, '2025-06-21 16:48:56.002217', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345584998830080, '2025-06-21 16:48:57.682704', 1, '$GNGGA,,,,,,0,00,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345593551015936, '2025-06-21 16:48:59.721958', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345603478933504, '2025-06-21 16:49:02.088235', 1, ',,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345611750100992, '2025-06-21 16:49:04.06062', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345619647975424, '2025-06-21 16:49:05.943199', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345626883149824, '2025-06-21 16:49:07.668243', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345634244153344, '2025-06-21 16:49:09.423349', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345643417096192, '2025-06-21 16:49:11.610866', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345652585844736, '2025-06-21 16:49:13.796789', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345660882178048, '2025-06-21 16:49:15.774797', 1, '$GPGSV,1,1,0ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345668218015744, '2025-06-21 16:49:17.523778', 1, '$GNGGA,,,,,,0,00,25.5,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345673884520448, '2025-06-21 16:49:18.874425', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345678661832704, '2025-06-21 16:49:20.013718', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345683833409536, '2025-06-21 16:49:21.246918', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345689139204096, '2025-06-21 16:49:22.51171', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345694340141056, '2025-06-21 16:49:23.751257', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345699784347648, '2025-06-21 16:49:25.049694', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345705773813760, '2025-06-21 16:49:26.477102', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345731140964352, '2025-06-21 16:49:32.525677', 1, '$BDGSV,1,1,00,0,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345763269332992, '2025-06-21 16:49:40.185397', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345763269332993, '2025-06-21 16:49:40.185397', 1, '$GNGLL,,,,,,V,N*,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345771217539072, '2025-06-21 16:49:42.080367', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345777303474176, '2025-06-21 16:49:43.531187', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345785000022016, '2025-06-21 16:49:45.366249', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345790909796352, '2025-06-21 16:49:46.775174', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345798610538496, '2025-06-21 16:49:48.611624', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345806705545216, '2025-06-21 16:49:50.541373', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345815207399424, '2025-06-21 16:49:52.568086', 1, '$GNRMC,,V,,,,,*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345821947645952, '2025-06-21 16:49:54.17576', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345828272656384, '2025-06-21 16:49:55.683583', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345834627026944, '2025-06-21 16:49:57.198496', 1, '74');
INSERT INTO "public"."device_temp_data" VALUES (1936345839844741120, '2025-06-21 16:49:58.442888', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345845641269248, '2025-06-21 16:49:59.824128', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345850473107456, '2025-06-21 16:50:00.976674', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345856198332416, '2025-06-21 16:50:02.341299', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345862552702976, '2025-06-21 16:50:03.85697', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936345870450577408, '2025-06-21 16:50:05.739187', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936345876351963136, '2025-06-21 16:50:07.146668', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936345881754226688, '2025-06-21 16:50:08.434535', 1, '$GNGNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345886346989568, '2025-06-21 16:50:09.529717', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345890943946752, '2025-06-21 16:50:10.625023', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345895490572288, '2025-06-21 16:50:11.70965', 1, ',,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936345900012032000, '2025-06-21 16:50:12.787497', 1, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936345904541880320, '2025-06-21 16:50:13.867864', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936345909109477376, '2025-06-21 16:50:14.956442', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936345913710628864, '2025-06-21 16:50:16.053587', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936345918412443648, '2025-06-21 16:50:17.174246', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936345922984235008, '2025-06-21 16:50:18.264962', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936345927623135232, '2025-06-21 16:50:19.370113', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346337779929088, '2025-06-21 16:51:57.159572', 1, '$GPTXT,01,01,02,IC=AT6558R-5N-32-1C580901*13');
INSERT INTO "public"."device_temp_data" VALUES (1936346342716624896, '2025-06-21 16:51:58.336418', 1, '$GPTXT,01,01,02,SW=URANUS5,V5.3.0.0*1D');
INSERT INTO "public"."device_temp_data" VALUES (1936346359829385216, '2025-06-21 16:52:02.41667', 1, '$GPTXT,01,01,02,TB=2020-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936346364522811392, '2025-06-21 16:52:03.534698', 1, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936346374090018816, '2025-06-21 16:52:05.81629', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346378812805120, '2025-06-21 16:52:06.942268', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936346383430733824, '2025-06-21 16:52:08.043943', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936346765737349120, '2025-06-21 16:53:39.192047', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346796175413248, '2025-06-21 16:53:46.449059', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936346826806415360, '2025-06-21 16:53:53.752413', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936346828710629376, '2025-06-21 16:53:54.206002', 1, '$GPGSV,1,1,04,06,,,32,30,,,33,31,,,30,194,,,32,0*59');
INSERT INTO "public"."device_temp_data" VALUES (1936346837564805120, '2025-06-21 16:53:56.317758', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936346843017400320, '2025-06-21 16:53:57.617758', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936346851389231104, '2025-06-21 16:53:59.613497', 1, '$GNVTG,,,,,,,,,N*,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352526756605952, '2025-06-21 17:16:32.726031', 194232147738608, ',*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346856065880064, '2025-06-21 16:54:00.72842', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936346860872552448, '2025-06-21 16:54:01.874681', 1, '$GPGSV,1,1,02,09,,,21,18,,,19,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936346865947660288, '2025-06-21 16:54:03.084567', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936346870775304192, '2025-06-21 16:54:04.235573', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936346886025793536, '2025-06-21 16:54:07.871763', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936346890652110848, '2025-06-21 16:54:08.974102', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936346895257456640, '2025-06-21 16:54:10.072952', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936346899942494208, '2025-06-21 16:54:11.189051', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346904711417856, '2025-06-21 16:54:12.326453', 1, ',18,,,19,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936346909304180736, '2025-06-21 16:54:13.421504', 1, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936346913917915136, '2025-06-21 16:54:14.521302', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936346918770724864, '2025-06-21 16:54:15.678054', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936346923476733952, '2025-06-21 16:54:16.800459', 1, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936346928103051264, '2025-06-21 16:54:17.903494', 1, '$G56');
INSERT INTO "public"."device_temp_data" VALUES (1936346932834226176, '2025-06-21 16:54:19.031461', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936346937498292224, '2025-06-21 16:54:20.143959', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346942120415232, '2025-06-21 16:54:21.245823', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936346946704789504, '2025-06-21 16:54:22.337589', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936346951310135296, '2025-06-21 16:54:23.436834', 1, '$GNGSA,A,1,,,,,,,,,,,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936346955970007040, '2025-06-21 16:54:24.547535', 1, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936346960659238912, '2025-06-21 16:54:25.665591', 1, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936346965226835968, '2025-06-21 16:54:26.754868', 1, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936346969878319104, '2025-06-21 16:54:27.863865', 1, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936346974483664896, '2025-06-21 16:54:28.961812', 1, '$,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936346979055456256, '2025-06-21 16:54:30.051211', 1, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936346983698550784, '2025-06-21 16:54:31.158603', 1, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347013922811904, '2025-06-21 16:54:38.309613', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347019295715328, '2025-06-21 16:54:39.645599', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347024106582016, '2025-06-21 16:54:40.792815', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347029009723392, '2025-06-21 16:54:41.961982', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347033757675520, '2025-06-21 16:54:43.093407', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347038325272576, '2025-06-21 16:54:44.182272', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347042943201280, '2025-06-21 16:54:45.28376', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347047615655936, '2025-06-21 16:54:46.397139', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347064371900416, '2025-06-21 16:54:50.392271', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347068989829120, '2025-06-21 16:54:51.493631', 194232147738608, '$GPTXT,01,01A,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347073653895168, '2025-06-21 16:54:52.605708', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347078271823872, '2025-06-21 16:54:53.706324', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347082914918400, '2025-06-21 16:54:54.813392', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347087545430016, '2025-06-21 16:54:55.917558', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347092188524544, '2025-06-21 16:54:57.024134', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347096798064640, '2025-06-21 16:54:58.123466', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347112761585664, '2025-06-21 16:55:01.929006', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347117429846016, '2025-06-21 16:55:03.04205', 194232147738608, '$GNGGA,,,,,,0,00,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347121989054464, '2025-06-21 16:55:04.129993', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347126590205952, '2025-06-21 16:55:05.226525', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347131250077696, '2025-06-21 16:55:06.337483', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347135880589312, '2025-06-21 16:55:07.441665', 194232147738608, '$GNGSAE');
INSERT INTO "public"."device_temp_data" VALUES (1936347140678873088, '2025-06-21 16:55:08.585209', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347145363910656, '2025-06-21 16:55:09.702288', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347149998616576, '2025-06-21 16:55:10.807065', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347154557825024, '2025-06-21 16:55:11.894381', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347159196725248, '2025-06-21 16:55:13.000755', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347163990814720, '2025-06-21 16:55:14.14398', 194232147738608, '$GNGS,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347168738766848, '2025-06-21 16:55:15.275603', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347173386055680, '2025-06-21 16:55:16.383035', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347177987207168, '2025-06-21 16:55:17.480906', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347182554804224, '2025-06-21 16:55:18.569761', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347187185315840, '2025-06-21 16:55:19.673575', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347191744524288, '2025-06-21 16:55:20.760119', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347196467310592, '2025-06-21 16:55:21.886761', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347201018130432, '2025-06-21 16:55:22.971062', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347205615087616, '2025-06-21 16:55:24.067537', 194232147738608, '$GNGGA,,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347210199461888, '2025-06-21 16:55:25.160144', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347214955802624, '2025-06-21 16:55:26.294106', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347219556954112, '2025-06-21 16:55:27.391492', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347224241991680, '2025-06-21 16:55:28.508747', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347228956389376, '2025-06-21 16:55:29.632653', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347233599483904, '2025-06-21 16:55:30.739558', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347244546617344, '2025-06-21 16:55:33.349341', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347249168740352, '2025-06-21 16:55:34.451907', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347253799251968, '2025-06-21 16:55:35.555685', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347261764235264, '2025-06-21 16:55:37.454593', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347266411524096, '2025-06-21 16:55:38.562422', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347271075590144, '2025-06-21 16:55:39.674042', 194232147738608, '*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347275890651136, '2025-06-21 16:55:40.822609', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347280516968448, '2025-06-21 16:55:41.925541', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347285252337664, '2025-06-21 16:55:43.05458', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347289954152448, '2025-06-21 16:55:44.175281', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347294593052672, '2025-06-21 16:55:45.281298', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347299206787072, '2025-06-21 16:55:46.381912', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347303870853120, '2025-06-21 16:55:47.49371', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347308467810304, '2025-06-21 16:55:48.58945', 194232147738608, '$GNGSA,A,1,,,,,,,,,,NGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347313064767488, '2025-06-21 16:55:49.685937', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347317665918976, '2025-06-21 16:55:50.782929', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347322376122368, '2025-06-21 16:55:51.905195', 194232147738608, '$BDGSV,1,1,01,29,,,27,0*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936347326964690944, '2025-06-21 16:55:52.999368', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347331603591168, '2025-06-21 16:55:54.105704', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347336246685696, '2025-06-21 16:55:55.212019', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347340839448576, '2025-06-21 16:55:56.307739', 194232147738608, '$GPTXT,011,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347345423822848, '2025-06-21 16:55:57.400071', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347349978836992, '2025-06-21 16:55:58.48624', 194232147738608, '$BDGSV,');
INSERT INTO "public"."device_temp_data" VALUES (1936347368169533440, '2025-06-21 16:56:02.822147', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347372728741888, '2025-06-21 16:56:03.910961', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347377355059200, '2025-06-21 16:56:05.013522', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347383164170240, '2025-06-21 16:56:06.398571', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347388071505920, '2025-06-21 16:56:07.568356', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347392949481472, '2025-06-21 16:56:08.731854', 194232147738608, '$BDGSV,1,1,01,29,,,26,0*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347397542244352, '2025-06-21 16:56:09.826566', 194232147738608, '$GNRM,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347402135007232, '2025-06-21 16:56:10.921141', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347406849404928, '2025-06-21 16:56:12.045189', 194232147738608, '$GNGSA,A,1,,,,,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347411555414016, '2025-06-21 16:56:13.167089', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347416139788288, '2025-06-21 16:56:14.260858', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347420782882816, '2025-06-21 16:56:15.367039', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347425526640640, '2025-06-21 16:56:16.498605', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347430102626304, '2025-06-21 16:56:17.589744', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347434695389184, '2025-06-21 16:56:18.684864', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347439430758400, '2025-06-21 16:56:19.813139', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347444078047232, '2025-06-21 16:56:20.921595', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347448670810112, '2025-06-21 16:56:22.016726', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347453334876160, '2025-06-21 16:56:23.1288', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347464445587456, '2025-06-21 16:56:25.777464', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0');
INSERT INTO "public"."device_temp_data" VALUES (1936347469063516160, '2025-06-21 16:56:26.878356', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347473694027776, '2025-06-21 16:56:27.982492', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347478441979904, '2025-06-21 16:56:29.114035', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347485471633408, '2025-06-21 16:56:30.789136', 194232147738608, '$GNGGA,,,,,,0,00');
INSERT INTO "public"."device_temp_data" VALUES (1936347490186031104, '2025-06-21 16:56:31.914432', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347494824931328, '2025-06-21 16:56:33.020545', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347499442860032, '2025-06-21 16:56:34.12182', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347504115314688, '2025-06-21 16:56:35.233848', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347508779380736, '2025-06-21 16:56:36.347764', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936347513464418304, '2025-06-21 16:56:37.464453', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936347518195593216, '2025-06-21 16:56:38.592643', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347522813521920, '2025-06-21 16:56:39.693851', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347527586639872, '2025-06-21 16:56:40.831302', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347532649164800, '2025-06-21 16:56:42.038958', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347537258704896, '2025-06-21 16:56:43.137223', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347546704277504, '2025-06-21 16:56:45.389246', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347551397703680, '2025-06-21 16:56:46.508474', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347567889707008, '2025-06-21 16:56:50.440578', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347572469886976, '2025-06-21 16:56:51.53263', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347577310113792, '2025-06-21 16:56:52.686188', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347581898682368, '2025-06-21 16:56:53.780092', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5NTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347586512416768, '2025-06-21 16:56:54.8809', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347591210037248, '2025-06-21 16:56:56.000132', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347595899269120, '2025-06-21 16:56:57.118128', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347600668192768, '2025-06-21 16:56:58.255633', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347605382590464, '2025-06-21 16:56:59.379422', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347610424143872, '2025-06-21 16:57:00.581761', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347615373422592, '2025-06-21 16:57:01.761528', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347620100403200, '2025-06-21 16:57:02.888228', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347638354014208, '2025-06-21 16:57:07.240909', 194232147738608, '$GNGSA,A,1,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347643068411904, '2025-06-21 16:57:08.364627', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347647728283648, '2025-06-21 16:57:09.475069', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347652350406656, '2025-06-21 16:57:10.577679', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347656976723968, '2025-06-21 16:57:11.680897', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347661636595712, '2025-06-21 16:57:12.791744', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347666220969984, '2025-06-21 16:57:13.883284', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0');
INSERT INTO "public"."device_temp_data" VALUES (1936347670847287296, '2025-06-21 16:57:14.987194', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347675662348288, '2025-06-21 16:57:16.135278', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347681798615040, '2025-06-21 16:57:17.598277', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347686810808320, '2025-06-21 16:57:18.793518', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347697313345536, '2025-06-21 16:57:21.297548', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347702778523648, '2025-06-21 16:57:22.600757', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347707375480832, '2025-06-21 16:57:23.696005', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347713331392512, '2025-06-21 16:57:25.116484', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347723846512640, '2025-06-21 16:57:27.623826', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347728523161600, '2025-06-21 16:57:28.738708', 194232147738608, '$GNGSA,A,1,,,,,,,,37');
INSERT INTO "public"."device_temp_data" VALUES (1936347733120118784, '2025-06-21 16:57:29.834121', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347737733853184, '2025-06-21 16:57:30.934722', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347756176207872, '2025-06-21 16:57:35.33171', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347760844468224, '2025-06-21 16:57:36.4441', 194232147738608, '1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347771493806080, '2025-06-21 16:57:38.983306', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347788048723968, '2025-06-21 16:57:42.930252', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347792800870400, '2025-06-21 16:57:44.063535', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347797439770624, '2025-06-21 16:57:45.16929', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347813269073920, '2025-06-21 16:57:48.943356', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347817958305792, '2025-06-21 16:57:50.06058', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347822496542720, '2025-06-21 16:57:51.143032', 194232147738608, '$GNGSA,A,1,,,,,,,,,$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936347887172710400, '2025-06-21 16:58:06.563161', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347887592140800, '2025-06-21 16:58:06.663384', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347887738941440, '2025-06-21 16:58:06.698915', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347893552246784, '2025-06-21 16:58:08.084918', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347898707046400, '2025-06-21 16:58:09.313398', 194232147738608, 'ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347903983480832, '2025-06-21 16:58:10.571547', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347908785958912, '2025-06-21 16:58:11.716412', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936347913391304704, '2025-06-21 16:58:12.81407', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936347918101508096, '2025-06-21 16:58:13.937203', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.7E');
INSERT INTO "public"."device_temp_data" VALUES (1936347922744602624, '2025-06-21 16:58:15.044698', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347943380578304, '2025-06-21 16:58:19.964726', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347947981729792, '2025-06-21 16:58:21.061462', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347952679350272, '2025-06-21 16:58:22.181756', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936347957255335936, '2025-06-21 16:58:23.272416', 194232147738608, '4');
INSERT INTO "public"."device_temp_data" VALUES (1936347961835515904, '2025-06-21 16:58:24.364075', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936347976909844480, '2025-06-21 16:58:27.958483', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936347981586493440, '2025-06-21 16:58:29.073682', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936347991040454656, '2025-06-21 16:58:31.327975', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936347996207837184, '2025-06-21 16:58:32.558705', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348000829960192, '2025-06-21 16:58:33.661795', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,2500,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348005426917376, '2025-06-21 16:58:34.75792', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348010246172672, '2025-06-21 16:58:35.906899', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348015149314048, '2025-06-21 16:58:37.075647', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348019746271232, '2025-06-21 16:58:38.171281', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348024309673984, '2025-06-21 16:58:39.259558', 194232147738608, 'W=URANUS5,V5.3.0.0*1D');
INSERT INTO "public"."device_temp_data" VALUES (1936348029401559040, '2025-06-21 16:58:40.473836', 194232147738608, '$GPTXT,01,01,02,TB=2020-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936348034069819392, '2025-06-21 16:58:41.586823', 194232147738608, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936348043880296448, '2025-06-21 16:58:43.925004', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348048494030848, '2025-06-21 16:58:45.025082', 194232147738608, '$GNGGA,,,,,3:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936348053015490560, '2025-06-21 16:58:46.103125', 194232147738608, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936348079888396288, '2025-06-21 16:58:52.510598', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348085907222528, '2025-06-21 16:58:53.945946', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348091166879744, '2025-06-21 16:58:55.199148', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348100159467520, '2025-06-21 16:58:57.343846', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348115363819520, '2025-06-21 16:59:00.968647', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936348119956582400, '2025-06-21 16:59:02.063043', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348124570316800, '2025-06-21 16:59:03.163456', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348140630306816, '2025-06-21 16:59:06.992344', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348155167764480, '2025-06-21 16:59:10.458656', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348176961368064, '2025-06-21 16:59:15.654106', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348181461856256, '2025-06-21 16:59:16.727356', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348186083979264, '2025-06-21 16:59:17.829741', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348201405771776, '2025-06-21 16:59:21.482382', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936348205964980224, '2025-06-21 16:59:22.569483', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348210578714624, '2025-06-21 16:59:23.669835', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348215121145856, '2025-06-21 16:59:24.752022', 194232147738608, '$GNVTG,,,,,,,,VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348219772628992, '2025-06-21 16:59:25.861313', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348224323448832, '2025-06-21 16:59:26.946291', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348228891045888, '2025-06-21 16:59:28.035951', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348233446060032, '2025-06-21 16:59:29.121652', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348238017851392, '2025-06-21 16:59:30.211297', 194232147738608, '$GNGSA,A,1,GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348242614808576, '2025-06-21 16:59:31.306837', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348247224348672, '2025-06-21 16:59:32.406518', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348251808722944, '2025-06-21 16:59:33.498724', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348256426651648, '2025-06-21 16:59:34.600852', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348260956499968, '2025-06-21 16:59:35.680265', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348265570234368, '2025-06-21 16:59:36.780381', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936348270121054208, '2025-06-21 16:59:37.865984', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348274659291136, '2025-06-21 16:59:38.947081', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348279218499584, '2025-06-21 16:59:40.034814', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348283890954240, '2025-06-21 16:59:41.1488', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348288605351936, '2025-06-21 16:59:42.272918', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348293172948992, '2025-06-21 16:59:43.361909', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348297711185920, '2025-06-21 16:59:44.443966', 194232147738608, '$GNGLL,,,,,0,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348302350086144, '2025-06-21 16:59:45.549689', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348306913488896, '2025-06-21 16:59:46.637128', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348311514640384, '2025-06-21 16:59:47.734458', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348316057071616, '2025-06-21 16:59:48.81771', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348325108379648, '2025-06-21 16:59:50.975852', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348329701142528, '2025-06-21 16:59:52.070639', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348338945388544, '2025-06-21 16:59:54.274661', 194232147738608, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936348343546540032, '2025-06-21 16:59:55.371652', 194232147738608, '$GNGGA,,,,,,0,V,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936348348130914304, '2025-06-21 16:59:56.464676', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348352719482880, '2025-06-21 16:59:57.558656', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348357366771712, '2025-06-21 16:59:58.66608', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348361959534592, '2025-06-21 16:59:59.761794', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348366480994304, '2025-06-21 17:00:00.839406', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348381895061504, '2025-06-21 17:00:04.514977', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348398814883840, '2025-06-21 17:00:08.548152', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348403579613184, '2025-06-21 17:00:09.684913', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348408415645696, '2025-06-21 17:00:10.837577', 194232147738608, '$GNGSA,A,1,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348412928716800, '2025-06-21 17:00:11.913008', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348417617948672, '2025-06-21 17:00:13.031245', 194232147738608, ',,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348434302889984, '2025-06-21 17:00:17.009343', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348451122049024, '2025-06-21 17:00:21.019636', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348455853223936, '2025-06-21 17:00:22.14727', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348460408238080, '2025-06-21 17:00:23.233391', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348465151995904, '2025-06-21 17:00:24.364182', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348469707010048, '2025-06-21 17:00:25.450858', 194232147738608, '$GPGSV,1,1,01,11,,,29,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936348474379464704, '2025-06-21 17:00:26.56437', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348478976421888, '2025-06-21 17:00:27.660021', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348483573379072, '2025-06-21 17:00:28.756702', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348488250028032, '2025-06-21 17:00:29.871009', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348518453211136, '2025-06-21 17:00:37.072409', 194232147738608, 'N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348535125569536, '2025-06-21 17:00:41.047795', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348539793829888, '2025-06-21 17:00:42.160869', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348544462090240, '2025-06-21 17:00:43.273834', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348549113573376, '2025-06-21 17:00:44.382785', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348553786028032, '2025-06-21 17:00:45.495978', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348558408151040, '2025-06-21 17:00:46.598174', 194232147738608, '$GNGSAL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348563193851904, '2025-06-21 17:00:47.739381', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348567971164160, '2025-06-21 17:00:48.878549', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348572631035904, '2025-06-21 17:00:49.989426', 194232147738608, '$GPGSV,3,1,09,02,,,34,05,,,36,08,,,31,11,,,35,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936348577223798784, '2025-06-21 17:00:51.084895', 194232147738608, 'ENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348581778812928, '2025-06-21 17:00:52.170038', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348586476433408, '2025-06-21 17:00:53.290764', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348591526375424, '2025-06-21 17:00:54.494519', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348596110749696, '2025-06-21 17:00:55.587301', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348601215217664, '2025-06-21 17:00:56.804557', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348607024328704, '2025-06-21 17:00:58.189451', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348612074270720, '2025-06-21 17:00:59.393042', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348616805445632, '2025-06-21 17:01:00.520228', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348646744387584, '2025-06-21 17:01:07.658771', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348651387482112, '2025-06-21 17:01:08.766668', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348656349343744, '2025-06-21 17:01:09.949496', 194232147738608, '$GNGSA,A,1,,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348661097295872, '2025-06-21 17:01:11.081048', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348665727807488, '2025-06-21 17:01:12.184201', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348670396067840, '2025-06-21 17:01:13.298916', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348675013996544, '2025-06-21 17:01:14.399285', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348679627730944, '2025-06-21 17:01:15.499224', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348684262436864, '2025-06-21 17:01:16.604203', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348688796479488, '2025-06-21 17:01:17.68529', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,2$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348693406019584, '2025-06-21 17:01:18.784143', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348698015559680, '2025-06-21 17:01:19.883791', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348702738345984, '2025-06-21 17:01:21.009989', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348707758927872, '2025-06-21 17:01:22.206507', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348724183822336, '2025-06-21 17:01:26.122236', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348728755613696, '2025-06-21 17:01:27.212135', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348733541314560, '2025-06-21 17:01:28.353276', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936348738138271744, '2025-06-21 17:01:29.449714', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348742735228928, '2025-06-21 17:01:30.545178', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348772690948096, '2025-06-21 17:01:37.687787', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348777250156544, '2025-06-21 17:01:38.77443', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348787463286784, '2025-06-21 17:01:41.209447', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348792102187008, '2025-06-21 17:01:42.315528', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348796694949888, '2025-06-21 17:01:43.410755', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348801254158336, '2025-06-21 17:01:44.497234', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348805821755392, '2025-06-21 17:01:45.586153', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348810548736000, '2025-06-21 17:01:46.713953', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348815107944448, '2025-06-21 17:01:47.800131', 194232147738608, '$GNGLL,,,,,,V,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936348819688124416, '2025-06-21 17:01:48.892618', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348824268304384, '2025-06-21 17:01:49.984183', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348828756209664, '2025-06-21 17:01:51.054758', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348833369944064, '2025-06-21 17:01:52.154308', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348838361165824, '2025-06-21 17:01:53.344791', 194232147738608, ',,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348843172032512, '2025-06-21 17:01:54.491126', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348860209295360, '2025-06-21 17:01:58.5539', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348864734949376, '2025-06-21 17:01:59.632264', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348869243826176, '2025-06-21 17:02:00.707134', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348873731731456, '2025-06-21 17:02:01.777298', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348878299328512, '2025-06-21 17:02:02.86632', 194232147738608, '$GNGSA,A,1,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348882816593920, '2025-06-21 17:02:03.943013', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348887350636544, '2025-06-21 17:02:05.024881', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348891825958912, '2025-06-21 17:02:06.091439', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348896397750272, '2025-06-21 17:02:07.181523', 194232147738608, 'NRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936348900894044160, '2025-06-21 17:02:08.253632', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348905394532352, '2025-06-21 17:02:09.326503', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348909886631936, '2025-06-21 17:02:10.397142', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348914429063168, '2025-06-21 17:02:11.480809', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348918950522880, '2025-06-21 17:02:12.558374', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348923463593984, '2025-06-21 17:02:13.634194', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25');
INSERT INTO "public"."device_temp_data" VALUES (1936348928052162560, '2025-06-21 17:02:14.728996', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348932582010880, '2025-06-21 17:02:15.808509', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348937141219328, '2025-06-21 17:02:16.895023', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348941654290432, '2025-06-21 17:02:17.971722', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348946209304576, '2025-06-21 17:02:19.057061', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348950789484544, '2025-06-21 17:02:20.149643', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348955348692992, '2025-06-21 17:02:21.236428', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936348959987593216, '2025-06-21 17:02:22.342511', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936348964597133312, '2025-06-21 17:02:23.441771', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348969152147456, '2025-06-21 17:02:24.527585', 194232147738608, '$GNGSA,A,1,,,,,,,,*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936348973702967296, '2025-06-21 17:02:25.612803', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936348978291535872, '2025-06-21 17:02:26.706862', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936348982846550016, '2025-06-21 17:02:27.792801', 194232147738608, ',25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936348988374642688, '2025-06-21 17:02:29.11074', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936348993013542912, '2025-06-21 17:02:30.216616', 194232147738608, '$GPGSV,1,1,01,28,,,31,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936348997623083008, '2025-06-21 17:02:31.315662', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349002169708544, '2025-06-21 17:02:32.399034', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349006678585344, '2025-06-21 17:02:33.474912', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349011237793792, '2025-06-21 17:02:34.561207', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349015792807936, '2025-06-21 17:02:35.647526', 194232147738608, '$GPTXT,01,01,01,ANTENNAG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349020377182208, '2025-06-21 17:02:36.740902', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349024911224832, '2025-06-21 17:02:37.821243', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349029495599104, '2025-06-21 17:02:38.914069', 194232147738608, '01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349034100944896, '2025-06-21 17:02:40.012094', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349038668541952, '2025-06-21 17:02:41.101064', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349043382939648, '2025-06-21 17:02:42.225042', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349047937953792, '2025-06-21 17:02:43.311804', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349052501356544, '2025-06-21 17:02:44.399222', 194232147738608, '$GPGSV,1,1,02,12,,,32,28,$GNGGA,,,,,,0,00,25.5,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349057073147904, '2025-06-21 17:02:45.489416', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349061590413312, '2025-06-21 17:02:46.56651', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349066158010368, '2025-06-21 17:02:47.65524', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349070805299200, '2025-06-21 17:02:48.763011', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349075536474112, '2025-06-21 17:02:49.891653', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349080083099648, '2025-06-21 17:02:50.975409', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349084646502400, '2025-06-21 17:02:52.063433', 194232147738608, '$GPGSV,1,1,04,03,,,30,09,,,32,12,,,35,28,,,36,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936349089239265280, '2025-06-21 17:02:53.158125', 194232147738608, '$BDGSDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349094071103488, '2025-06-21 17:02:54.310034', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349098663866368, '2025-06-21 17:02:55.405967', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349103319543808, '2025-06-21 17:02:56.515967', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349108554035200, '2025-06-21 17:02:57.763038', 194232147738608, '$GPTXT,01,01,01,T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349113121632256, '2025-06-21 17:02:58.852567', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349117710200832, '2025-06-21 17:02:59.946755', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349124207177728, '2025-06-21 17:03:01.49597', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349128921575424, '2025-06-21 17:03:02.619252', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,');
INSERT INTO "public"."device_temp_data" VALUES (1936349133459812352, '2025-06-21 17:03:03.701579', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349138006437888, '2025-06-21 17:03:04.785161', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349142561452032, '2025-06-21 17:03:05.871633', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349147120660480, '2025-06-21 17:03:06.95872', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349151717617664, '2025-06-21 17:03:08.054128', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349156322963456, '2025-06-21 17:03:09.152995', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349161309990912, '2025-06-21 17:03:10.34117', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349166108274688, '2025-06-21 17:03:11.484047', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349170654900224, '2025-06-21 17:03:12.569258', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349175251857408, '2025-06-21 17:03:13.665517', 194232147738608, '$GNGLL,,');
INSERT INTO "public"."device_temp_data" VALUES (1936349179848814592, '2025-06-21 17:03:14.761146', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349184361885696, '2025-06-21 17:03:15.837373', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349188904316928, '2025-06-21 17:03:16.920841', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349193526439936, '2025-06-21 17:03:18.022879', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349198144368640, '2025-06-21 17:03:19.123038', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349202728742912, '2025-06-21 17:03:20.216412', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349207325700096, '2025-06-21 17:03:21.312059', 194232147738608, '$GNGL,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349211889102848, '2025-06-21 17:03:22.400893', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349216494448640, '2025-06-21 17:03:23.49843', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349221074628608, '2025-06-21 17:03:24.590725', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349225629642752, '2025-06-21 17:03:25.676275', 194232147738608, '$GNG,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349230193045504, '2025-06-21 17:03:26.764895', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349234802585600, '2025-06-21 17:03:27.863461', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349239479234560, '2025-06-21 17:03:28.978448', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349272312246272, '2025-06-21 17:03:36.806188', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349272358383616, '2025-06-21 17:03:36.817349', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349277429297152, '2025-06-21 17:03:38.026903', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349282013671424, '2025-06-21 17:03:39.119011', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349286698708992, '2025-06-21 17:03:40.236345', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349291446661120, '2025-06-21 17:03:41.368005', 194232147738608, '$GNGS');
INSERT INTO "public"."device_temp_data" VALUES (1936349296165253120, '2025-06-21 17:03:42.493054', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349300791570432, '2025-06-21 17:03:43.596935', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349305367556096, '2025-06-21 17:03:44.687458', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349310019039232, '2025-06-21 17:03:45.796761', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349314574053376, '2025-06-21 17:03:46.882744', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349319124873216, '2025-06-21 17:03:47.967808', 194232147738608, ',,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349323663110144, '2025-06-21 17:03:49.049466', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349328243290112, '2025-06-21 17:03:50.141598', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349332823470080, '2025-06-21 17:03:51.233023', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349337357512704, '2025-06-21 17:03:52.314038', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349341996412928, '2025-06-21 17:03:53.420124', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349347847467008, '2025-06-21 17:03:54.815638', 194232147738608, '$GNSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349354281529344, '2025-06-21 17:03:56.349975', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349358815571968, '2025-06-21 17:03:57.430904', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349363349614592, '2025-06-21 17:03:58.511269', 194232147738608, '$GNVTG,,,,,1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349367892045824, '2025-06-21 17:03:59.594754', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349372430282752, '2025-06-21 17:04:00.676473', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349377207595008, '2025-06-21 17:04:01.815149', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349382580498432, '2025-06-21 17:04:03.096323', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349387101958144, '2025-06-21 17:04:04.174043', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349391656972288, '2025-06-21 17:04:05.260557', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349396216180736, '2025-06-21 17:04:06.347487', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349400808943616, '2025-06-21 17:04:07.442287', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349405389123584, '2025-06-21 17:04:08.534566', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349409923166208, '2025-06-21 17:04:09.615539', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349414490763264, '2025-06-21 17:04:10.704128', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936349419062554624, '2025-06-21 17:04:11.794338', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349423927947264, '2025-06-21 17:04:12.954565', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349432899563520, '2025-06-21 17:04:15.093618', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349437479743488, '2025-06-21 17:04:16.18561', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*041,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349442034757632, '2025-06-21 17:04:17.271007', 194232147738608, '$GNGGA,,,,,,0G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349446581383168, '2025-06-21 17:04:18.355687', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349451140591616, '2025-06-21 17:04:19.442221', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349466453995520, '2025-06-21 17:04:23.093227', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349472686731264, '2025-06-21 17:04:24.579926', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349477313048576, '2025-06-21 17:04:25.68282', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349481855479808, '2025-06-21 17:04:26.765777', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349486435659776, '2025-06-21 17:04:27.857815', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349491020034048, '2025-06-21 17:04:28.95024', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349495616991232, '2025-06-21 17:04:30.046334', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349500142645248, '2025-06-21 17:04:31.125737', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349504668299264, '2025-06-21 17:04:32.204854', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349509328171008, '2025-06-21 17:04:33.315906', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349513979654144, '2025-06-21 17:04:34.4247', 194232147738608, '1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349518568222720, '2025-06-21 17:04:35.518173', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349523089682432, '2025-06-21 17:04:36.596384', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349527611142144, '2025-06-21 17:04:37.674009', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349532111630336, '2025-06-21 17:04:38.747626', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349536633090048, '2025-06-21 17:04:39.825206', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349541175521280, '2025-06-21 17:04:40.908566', 194232147738608, '$GNGLL,,,,,,V,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349545759895552, '2025-06-21 17:04:42.00175', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349550402990080, '2025-06-21 17:04:43.108006', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349554978975744, '2025-06-21 17:04:44.199279', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349559538184192, '2025-06-21 17:04:45.286969', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349564038672384, '2025-06-21 17:04:46.359097', 194232147738608, ',V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349568547549184, '2025-06-21 17:04:47.434424', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349573089980416, '2025-06-21 17:04:48.51732', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349577598857216, '2025-06-21 17:04:49.592914', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349582128705536, '2025-06-21 17:04:50.672347', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349586713079808, '2025-06-21 17:04:51.76585', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349591234539520, '2025-06-21 17:04:52.84329', 194232147738608, '$GNGSA,A,1,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349595776970752, '2025-06-21 17:04:53.926518', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349600344567808, '2025-06-21 17:04:55.015111', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349604882804736, '2025-06-21 17:04:56.096499', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349609442013184, '2025-06-21 17:04:57.184709', 194232147738608, ',V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349614013804544, '2025-06-21 17:04:58.274149', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349618531069952, '2025-06-21 17:04:59.351662', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349623081889792, '2025-06-21 17:05:00.436734', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349627565600768, '2025-06-21 17:05:01.50548', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349632082866176, '2025-06-21 17:05:02.582573', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349636633686016, '2025-06-21 17:05:03.667163', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.55,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349641180311552, '2025-06-21 17:05:04.751453', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349645735325696, '2025-06-21 17:05:05.837567', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349650311311360, '2025-06-21 17:05:06.928419', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349654904074240, '2025-06-21 17:05:08.023739', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349659429728256, '2025-06-21 17:05:09.10253', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349663988936704, '2025-06-21 17:05:10.189344', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349668535562240, '2025-06-21 17:05:11.273261', 194232147738608, '$,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349673690361856, '2025-06-21 17:05:12.502171', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349678492839936, '2025-06-21 17:05:13.647995', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349683022688256, '2025-06-21 17:05:14.72764', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349687594479616, '2025-06-21 17:05:15.817401', 194232147738608, 'A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349692162076672, '2025-06-21 17:05:16.906982', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349696733868032, '2025-06-21 17:05:17.996577', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349701339213824, '2025-06-21 17:05:19.094403', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349705864867840, '2025-06-21 17:05:20.173819', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349710390521856, '2025-06-21 17:05:21.252595', 194232147738608, '$GPGSV,1,1,00,*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349714941341696, '2025-06-21 17:05:22.337056', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349719517327360, '2025-06-21 17:05:23.428648', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349724147838976, '2025-06-21 17:05:24.53205', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349728744796160, '2025-06-21 17:05:25.628336', 194232147738608, 'GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349733396279296, '2025-06-21 17:05:26.737025', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349738001625088, '2025-06-21 17:05:27.83516', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349742527279104, '2025-06-21 17:05:28.914933', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349747195539456, '2025-06-21 17:05:30.027074', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349753034010624, '2025-06-21 17:05:31.419884', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349758876676096, '2025-06-21 17:05:32.812865', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349763490410496, '2025-06-21 17:05:33.912534', 194232147738608, '$GNVTG,,,,,,,,,N*2E.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349768003481600, '2025-06-21 17:05:34.988997', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349772533329920, '2025-06-21 17:05:36.068028', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349777046401024, '2025-06-21 17:05:37.144764', 194232147738608, '$BDGSV');
INSERT INTO "public"."device_temp_data" VALUES (1936349781584637952, '2025-06-21 17:05:38.226141', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349786089320448, '2025-06-21 17:05:39.300346', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349802312888320, '2025-06-21 17:05:43.168473', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349806993731584, '2025-06-21 17:05:44.284377', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349811703934976, '2025-06-21 17:05:45.407454', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349816443498496, '2025-06-21 17:05:46.537459', 194232147738608, '$GNGGA,,,,,,0,0N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349821157896192, '2025-06-21 17:05:47.661823', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349826681794560, '2025-06-21 17:05:48.978584', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349831639461888, '2025-06-21 17:05:50.160081', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349836186087424, '2025-06-21 17:05:51.244736', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349840824987648, '2025-06-21 17:05:52.350115', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349845434527744, '2025-06-21 17:05:53.449588', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349849989541888, '2025-06-21 17:05:54.535283', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349854531973120, '2025-06-21 17:05:55.6185', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349859107958784, '2025-06-21 17:05:56.709553', 194232147738608, '$GNRMCL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349863654584320, '2025-06-21 17:05:57.793453', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349868306067456, '2025-06-21 17:05:58.902931', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936349872898830336, '2025-06-21 17:05:59.997603', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349877466427392, '2025-06-21 17:06:01.086562', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349882008858624, '2025-06-21 17:06:02.169618', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349886589038592, '2025-06-21 17:06:03.261982', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349891232133120, '2025-06-21 17:06:04.368329', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349895841673216, '2025-06-21 17:06:05.46788', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25NNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349900518322176, '2025-06-21 17:06:06.582635', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349905077530624, '2025-06-21 17:06:07.669154', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349909695459328, '2025-06-21 17:06:08.770539', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349914367913984, '2025-06-21 17:06:09.884232', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349923729600512, '2025-06-21 17:06:12.116035', 194232147738608, '$GPGSV,1,1,00,0*6GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349928339140608, '2025-06-21 17:06:13.215271', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349932910931968, '2025-06-21 17:06:14.305235', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349937474334720, '2025-06-21 17:06:15.393924', 194232147738608, '$GNG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936349942016765952, '2025-06-21 17:06:16.476739', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936349946575974400, '2025-06-21 17:06:17.563583', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936349951646887936, '2025-06-21 17:06:18.772274', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936349956201902080, '2025-06-21 17:06:19.858351', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349960769499136, '2025-06-21 17:06:20.947528', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349966545055744, '2025-06-21 17:06:22.324556', 194232147738608, '$GNGSA,A,1,,64');
INSERT INTO "public"."device_temp_data" VALUES (1936349971414642688, '2025-06-21 17:06:23.485073', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936349975952879616, '2025-06-21 17:06:24.567106', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349980474339328, '2025-06-21 17:06:25.645892', 194232147738608, '$GNGSA,A,1,,,,,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936349985029353472, '2025-06-21 17:06:26.731263', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936349989567590400, '2025-06-21 17:06:27.813843', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936349994126798848, '2025-06-21 17:06:28.900284', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936349998765699072, '2025-06-21 17:06:30.006895', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350003295547392, '2025-06-21 17:06:31.086921', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350007854755840, '2025-06-21 17:06:32.173626', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350012409769984, '2025-06-21 17:06:33.259541', 194232147738608, '$GPTXT,01,01,01,ANTENNA ONZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350016968978432, '2025-06-21 17:06:34.346009', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350021486243840, '2025-06-21 17:06:35.423452', 194232147738608, '$GNGGA,,,,,,0,00,ENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350026011897856, '2025-06-21 17:06:36.50238', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350030554329088, '2025-06-21 17:06:37.585861', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350035105148928, '2025-06-21 17:06:38.67058', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350039647580160, '2025-06-21 17:06:39.753957', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350044257120256, '2025-06-21 17:06:40.852378', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350048883437568, '2025-06-21 17:06:41.955503', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350053438451712, '2025-06-21 17:06:43.04132', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350057955717120, '2025-06-21 17:06:44.118035', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350062481371136, '2025-06-21 17:06:45.197833', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350067019608064, '2025-06-21 17:06:46.279019', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350071532679168, '2025-06-21 17:06:47.355615', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350076125442048, '2025-06-21 17:06:48.450036', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350083218010112, '2025-06-21 17:06:50.141252', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,0,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350087722692608, '2025-06-21 17:06:51.215469', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350092260929536, '2025-06-21 17:06:52.297921', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350096786583552, '2025-06-21 17:06:53.376251', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350101278683136, '2025-06-21 17:06:54.447391', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350105770782720, '2025-06-21 17:06:55.518859', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350110279659520, '2025-06-21 17:06:56.59384', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350114796924928, '2025-06-21 17:06:57.670845', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350119272247296, '2025-06-21 17:06:58.737229', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350123827261440, '2025-06-21 17:06:59.823137', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350128319361024, '2025-06-21 17:07:00.894795', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350132891152384, '2025-06-21 17:07:01.984369', 194232147738608, ',A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350137412612096, '2025-06-21 17:07:03.062088', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350142366085120, '2025-06-21 17:07:04.243272', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350147097260032, '2025-06-21 17:07:05.371576', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350151601942528, '2025-06-21 17:07:06.445055', 194232147738608, '$GNRMC,,V,,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350156148568064, '2025-06-21 17:07:07.52956', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350160699387904, '2025-06-21 17:07:08.614431', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350165300539392, '2025-06-21 17:07:09.711148', 194232147738608, '$GNZDA,,,,,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350169834582016, '2025-06-21 17:07:10.792211', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350174372818944, '2025-06-21 17:07:11.874999', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350178940416000, '2025-06-21 17:07:12.963836', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350183596093440, '2025-06-21 17:07:14.073582', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350188251770880, '2025-06-21 17:07:15.183208', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350192785813504, '2025-06-21 17:07:16.26452', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350197462462464, '2025-06-21 17:07:17.379125', 194232147738608, ',25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350201992310784, '2025-06-21 17:07:18.458403', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350206509576192, '2025-06-21 17:07:19.536362', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350211110727680, '2025-06-21 17:07:20.633804', 194232147738608, '$BDGSV,1,1,0001,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350215594438656, '2025-06-21 17:07:21.702277', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350220115898368, '2025-06-21 17:07:22.780539', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350224708661248, '2025-06-21 17:07:23.875279', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350229305618432, '2025-06-21 17:07:24.971761', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350233919352832, '2025-06-21 17:07:26.071332', 194232147738608, 'OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350238512115712, '2025-06-21 17:07:27.166111', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350243121655808, '2025-06-21 17:07:28.265413', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350247710224384, '2025-06-21 17:07:29.359313', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350252227489792, '2025-06-21 17:07:30.436941', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350256925110272, '2025-06-21 17:07:31.556043', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350262163795968, '2025-06-21 17:07:32.805581', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350266702032896, '2025-06-21 17:07:33.887873', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350271278018560, '2025-06-21 17:07:34.978587', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350275866587136, '2025-06-21 17:07:36.07261', 194232147738608, '$GNVTG,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350280425795584, '2025-06-21 17:07:37.159248', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350285014364160, '2025-06-21 17:07:38.253457', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350289611321344, '2025-06-21 17:07:39.349988', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350298721349632, '2025-06-21 17:07:41.521697', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350303267975168, '2025-06-21 17:07:42.605918', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350307822989312, '2025-06-21 17:07:43.691969', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350312382197760, '2025-06-21 17:07:44.77817', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350316928823296, '2025-06-21 17:07:45.862764', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350321450283008, '2025-06-21 17:07:46.940779', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350325950771200, '2025-06-21 17:07:48.013875', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350330459648000, '2025-06-21 17:07:49.088958', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350334993690624, '2025-06-21 17:07:50.169504', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350339594842112, '2025-06-21 17:07:51.266657', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350344133079040, '2025-06-21 17:07:52.348513', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350348734230528, '2025-06-21 17:07:53.445695', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350353293438976, '2025-06-21 17:07:54.532912', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350357861036032, '2025-06-21 17:07:55.621095', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350362441216000, '2025-06-21 17:07:56.713241', 194232147738608, '$BDGSV,1,1,,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350367038173184, '2025-06-21 17:07:57.809149', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350371597381632, '2025-06-21 17:07:58.896053', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350376152395776, '2025-06-21 17:07:59.982737', 194232147738608, '$GNGSA,A,1,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350380652883968, '2025-06-21 17:08:01.055473', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350395806904320, '2025-06-21 17:08:04.668119', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350400349335552, '2025-06-21 17:08:05.751847', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350404891766784, '2025-06-21 17:08:06.834771', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350409438392320, '2025-06-21 17:08:07.918416', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350414018572288, '2025-06-21 17:08:09.010916', 194232147738608, '$GNZDA,,,,,,*PEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350418590363648, '2025-06-21 17:08:10.10088', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350423199903744, '2025-06-21 17:08:11.199019', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350427767500800, '2025-06-21 17:08:12.287721', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350432322514944, '2025-06-21 17:08:13.374954', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350436873334784, '2025-06-21 17:08:14.45978', 194232147738608, '$GPGSV,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936350454518771712, '2025-06-21 17:08:18.666301', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350459245752320, '2025-06-21 17:08:19.793362', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350463842709504, '2025-06-21 17:08:20.88969', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350468456443904, '2025-06-21 17:08:21.989885', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350473011458048, '2025-06-21 17:08:23.075298', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350477545500672, '2025-06-21 17:08:24.156352', 194232147738608, '0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350482121486336, '2025-06-21 17:08:25.24749', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350486710054912, '2025-06-21 17:08:26.341968', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350491319595008, '2025-06-21 17:08:27.440341', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350495807500288, '2025-06-21 17:08:28.51003', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350500324765696, '2025-06-21 17:08:29.587243', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350504875585536, '2025-06-21 17:08:30.672806', 194232147738608, '$GNGGA,,,,,,056');
INSERT INTO "public"."device_temp_data" VALUES (1936350509426405376, '2025-06-21 17:08:31.757852', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350514082082816, '2025-06-21 17:08:32.86722', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350518586765312, '2025-06-21 17:08:33.941442', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350525209571328, '2025-06-21 17:08:35.520988', 194232147738608, '$GNGSA,A,SV,1,1,03,15,,,29,17,,,28,28,,,32,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936350531425529856, '2025-06-21 17:08:37.002313', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350536194453504, '2025-06-21 17:08:38.139854', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350540799799296, '2025-06-21 17:08:39.237733', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350555047849984, '2025-06-21 17:08:42.634809', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350559598669824, '2025-06-21 17:08:43.719887', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350564183044096, '2025-06-21 17:08:44.812028', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350568717086720, '2025-06-21 17:08:45.893018', 194232147738608, '$GNGLL$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350573305655296, '2025-06-21 17:08:46.987978', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350577877446656, '2025-06-21 17:08:48.077227', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350582394712064, '2025-06-21 17:08:49.154805', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350586949726208, '2025-06-21 17:08:50.240447', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350591500546048, '2025-06-21 17:08:51.325392', 194232147738608, 'DGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350596072337408, '2025-06-21 17:08:52.415495', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350600694460416, '2025-06-21 17:08:53.517122', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350605287223296, '2025-06-21 17:08:54.612742', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350609892569088, '2025-06-21 17:08:55.710439', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350614502109184, '2025-06-21 17:08:56.809045', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350619023568896, '2025-06-21 17:08:57.887722', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350623540834304, '2025-06-21 17:08:58.964357', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350628133597184, '2025-06-21 17:09:00.059092', 194232147738608, 'A,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350632671834112, '2025-06-21 17:09:01.141043', 194232147738608, '$GPGSV,1,1,03,30,,,29,31,,,26,199,,,26,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1936350637197488128, '2025-06-21 17:09:02.220795', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350641731530752, '2025-06-21 17:09:03.301159', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350646273961984, '2025-06-21 17:09:04.384484', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350650946416640, '2025-06-21 17:09:05.49845', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350655539179520, '2025-06-21 17:09:06.59301', 194232147738608, '$GPTXT,01,01,01,ANTENNA,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350660110970880, '2025-06-21 17:09:07.683618', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350664678567936, '2025-06-21 17:09:08.77284', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350669346828288, '2025-06-21 17:09:09.885395', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350673968951296, '2025-06-21 17:09:10.98794', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350678532354048, '2025-06-21 17:09:12.075605', 194232147738608, 'NGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350683162865664, '2025-06-21 17:09:13.179271', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350687738851328, '2025-06-21 17:09:14.270205', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350692302254080, '2025-06-21 17:09:15.35831', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350696895016960, '2025-06-21 17:09:16.453105', 194232147738608, '$GPGSV,2,1,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350701479391232, '2025-06-21 17:09:17.546855', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350706013433856, '2025-06-21 17:09:18.627937', 194232147738608, '$GPGSV,2,1,08,03,,,34,04,,,30,12,,,37,27,,,32,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936350724690669568, '2025-06-21 17:09:23.080092', 194232147738608, '$GPGS4');
INSERT INTO "public"."device_temp_data" VALUES (1936350729207934976, '2025-06-21 17:09:24.15735', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350733775532032, '2025-06-21 17:09:25.246988', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350738397655040, '2025-06-21 17:09:26.348332', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350743003000832, '2025-06-21 17:09:27.446172', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350747583180800, '2025-06-21 17:09:28.53863', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350752163360768, '2025-06-21 17:09:29.630006', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350756680626176, '2025-06-21 17:09:30.707793', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350761319526400, '2025-06-21 17:09:31.813737', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350765866151936, '2025-06-21 17:09:32.897109', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350770404388864, '2025-06-21 17:09:33.97911', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350774980374528, '2025-06-21 17:09:35.070704', 194232147738608, 'GGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350779527000064, '2025-06-21 17:09:36.154817', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350784102985728, '2025-06-21 17:09:37.245228', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350788808994816, '2025-06-21 17:09:38.367064', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350793347231744, '2025-06-21 17:09:39.449212', 194232147738608, '$GP,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936350797998714880, '2025-06-21 17:09:40.55855', 194232147738608, '$GPGSV,4,2,16,09,,,35,11,,,35,12,,,37,17,,,34,0*,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350802687946752, '2025-06-21 17:09:41.676303', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350807389761536, '2025-06-21 17:09:42.797493', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350812007690240, '2025-06-21 17:09:43.898192', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350816541732864, '2025-06-21 17:09:44.979698', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350821117718528, '2025-06-21 17:09:46.070679', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350825647566848, '2025-06-21 17:09:47.150056', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350830156443648, '2025-06-21 17:09:48.225978', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350834740817920, '2025-06-21 17:09:49.318683', 194232147738608, '$GPGSV,1,1,04,12,,,19,13,,,19,30,,,2,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350839237111808, '2025-06-21 17:09:50.390419', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350843766960128, '2025-06-21 17:09:51.47015', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350848326168576, '2025-06-21 17:09:52.557443', 194232147738608, '$GPTXT,01,01,01,ANTENN');
INSERT INTO "public"."device_temp_data" VALUES (1936350852851822592, '2025-06-21 17:09:53.636299', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350857398448128, '2025-06-21 17:09:54.720687', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350861961850880, '2025-06-21 17:09:55.80813', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350866479116288, '2025-06-21 17:09:56.885326', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350871029936128, '2025-06-21 17:09:57.970253', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350875547201536, '2025-06-21 17:09:59.047181', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350880098021376, '2025-06-21 17:10:00.132593', 194232147738608, '$GNGSA,V,1,1,02,09,,,19,12,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350884623675392, '2025-06-21 17:10:01.211704', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350889233215488, '2025-06-21 17:10:02.310235', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350893767258112, '2025-06-21 17:10:03.391038', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350898267746304, '2025-06-21 17:10:04.464522', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350903401574400, '2025-06-21 17:10:05.688054', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350908124360704, '2025-06-21 17:10:06.814145', 194232147738608, '$GNGG');
INSERT INTO "public"."device_temp_data" VALUES (1936350912658403328, '2025-06-21 17:10:07.89535', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350917217611776, '2025-06-21 17:10:08.982737', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350921764237312, '2025-06-21 17:10:10.066868', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350926256336896, '2025-06-21 17:10:11.137305', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350930790379520, '2025-06-21 17:10:12.218644', 194232147738608, '$GN,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350935337005056, '2025-06-21 17:10:13.302562', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350939875241984, '2025-06-21 17:10:14.38401', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350944388313088, '2025-06-21 17:10:15.460316', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350948947521536, '2025-06-21 17:10:16.547076', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936350953473175552, '2025-06-21 17:10:17.626182', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936350958028189696, '2025-06-21 17:10:18.712104', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936350962549649408, '2025-06-21 17:10:19.790494', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936350967121440768, '2025-06-21 17:10:20.880923', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936350971655483392, '2025-06-21 17:10:21.961906', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936350976231469056, '2025-06-21 17:10:23.052833', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350980815843328, '2025-06-21 17:10:24.145024', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936350985362468864, '2025-06-21 17:10:25.22901', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936350989955231744, '2025-06-21 17:10:26.324136', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936350994543800320, '2025-06-21 17:10:27.418998', 194232147738608, 'RMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936350999144951808, '2025-06-21 17:10:28.515489', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351003716743168, '2025-06-21 17:10:29.605154', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351008405975040, '2025-06-21 17:10:30.723424', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351013132955648, '2025-06-21 17:10:31.85043', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351017759272960, '2025-06-21 17:10:32.953003', 194232147738608, '$GNGLL,,,,,,V,N*7A5.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351022280732672, '2025-06-21 17:10:34.031861', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351026865106944, '2025-06-21 17:10:35.124576', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351031407538176, '2025-06-21 17:10:36.207132', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351035933192192, '2025-06-21 17:10:37.286284', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351040542732288, '2025-06-21 17:10:38.385185', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351045085163520, '2025-06-21 17:10:39.468857', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351049778589696, '2025-06-21 17:10:40.587117', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351054488793088, '2025-06-21 17:10:41.710795', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351059123499008, '2025-06-21 17:10:42.815832', 194232147738608, '$DGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351063691096064, '2025-06-21 17:10:43.904872', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351068237721600, '2025-06-21 17:10:44.988138', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351072838873088, '2025-06-21 17:10:46.085744', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351077427441664, '2025-06-21 17:10:47.179135', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351082024398848, '2025-06-21 17:10:48.275608', 194232147738608, '7,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936351086591995904, '2025-06-21 17:10:49.364873', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351091117649920, '2025-06-21 17:10:50.443391', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351095689441280, '2025-06-21 17:10:51.533876', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351100265426944, '2025-06-21 17:10:52.624271', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351104812052480, '2025-06-21 17:10:53.708198', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351109400621056, '2025-06-21 17:10:54.802532', 194232147738608, '$GNGGA,,,,,,0,0,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351113951440896, '2025-06-21 17:10:55.887413', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351119206903808, '2025-06-21 17:10:57.140419', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351124244262912, '2025-06-21 17:10:58.341757', 194232147738608, '01,17,,,18,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936351128866385920, '2025-06-21 17:10:59.443225', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351133404622848, '2025-06-21 17:11:00.525142', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351138005774336, '2025-06-21 17:11:01.622204', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351142615314432, '2025-06-21 17:11:02.721164', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351147170328576, '2025-06-21 17:11:03.807417', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351151863754752, '2025-06-21 17:11:04.926485', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351156532015104, '2025-06-21 17:11:06.039291', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351161103806464, '2025-06-21 17:11:07.129582', 194232147738608, '$GNGSA,A,1,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936351165646237696, '2025-06-21 17:11:08.212414', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351170222223360, '2025-06-21 17:11:09.303082', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351174806597632, '2025-06-21 17:11:10.396349', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351179365806080, '2025-06-21 17:11:11.48389', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351183979540480, '2025-06-21 17:11:12.58399', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351188530360320, '2025-06-21 17:11:13.668684', 194232147738608, '00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351193097957376, '2025-06-21 17:11:14.757969', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351197690720256, '2025-06-21 17:11:15.852411', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351202333814784, '2025-06-21 17:11:16.959596', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351206964326400, '2025-06-21 17:11:18.06347', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351211565477888, '2025-06-21 17:11:19.160869', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351216137269248, '2025-06-21 17:11:20.250999', 194232147738608, '$GNGGA,,,,TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351220675506176, '2025-06-21 17:11:21.332757', 194232147738608, '$GNGGA,,,,,,0,00,7');
INSERT INTO "public"."device_temp_data" VALUES (1936351225243103232, '2025-06-21 17:11:22.421401', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351229819088896, '2025-06-21 17:11:23.512942', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351234411851776, '2025-06-21 17:11:24.60722', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351238983643136, '2025-06-21 17:11:25.697598', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351243521880064, '2025-06-21 17:11:26.779358', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351248156585984, '2025-06-21 17:11:27.884712', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351252732571648, '2025-06-21 17:11:28.975156', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351257337917440, '2025-06-21 17:11:30.073317', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351261939068928, '2025-06-21 17:11:31.170646', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351266594746368, '2025-06-21 17:11:32.28004', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351271208480768, '2025-06-21 17:11:33.38047', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351275784466432, '2025-06-21 17:11:34.471095', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351280339480576, '2025-06-21 17:11:35.557849', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351284940632064, '2025-06-21 17:11:36.654688', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351289655029760, '2025-06-21 17:11:37.778617', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351294184878080, '2025-06-21 17:11:38.85874', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351298777640960, '2025-06-21 17:11:39.95358', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351303454289920, '2025-06-21 17:11:41.068393', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351308068024320, '2025-06-21 17:11:42.168965', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,37');
INSERT INTO "public"."device_temp_data" VALUES (1936351312698535936, '2025-06-21 17:11:43.272797', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351317282910208, '2025-06-21 17:11:44.36514', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351321875673088, '2025-06-21 17:11:45.460627', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351326543933440, '2025-06-21 17:11:46.572108', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351331136696320, '2025-06-21 17:11:47.668591', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351335695904768, '2025-06-21 17:11:48.755503', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351341161082880, '2025-06-21 17:11:50.058252', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351345871286272, '2025-06-21 17:11:51.181205', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351350426300416, '2025-06-21 17:11:52.267256', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351355014868992, '2025-06-21 17:11:53.361313', 194232147738608, '$GNGSA,A,1,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351359779598336, '2025-06-21 17:11:54.497347', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351364452052992, '2025-06-21 17:11:55.611218', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351369057398784, '2025-06-21 17:11:56.709032', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351373612412928, '2025-06-21 17:11:57.795117', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351378188398592, '2025-06-21 17:11:58.886237', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351382785355776, '2025-06-21 17:11:59.982977', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351387403284480, '2025-06-21 17:12:01.083592', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351391991853056, '2025-06-21 17:12:02.177975', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351396546867200, '2025-06-21 17:12:03.263491', 194232147738608, '$GPGSV,1');
INSERT INTO "public"."device_temp_data" VALUES (1936351401080909824, '2025-06-21 17:12:04.344245', 194232147738608, '$GNGGA,,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351405698838528, '2025-06-21 17:12:05.445106', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351410249658368, '2025-06-21 17:12:06.530079', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351414762729472, '2025-06-21 17:12:07.606678', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351419326132224, '2025-06-21 17:12:08.694467', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351423918895104, '2025-06-21 17:12:09.78981', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351428444549120, '2025-06-21 17:12:10.868718', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351432991174656, '2025-06-21 17:12:11.952948', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351437558771712, '2025-06-21 17:12:13.041839', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351442248003584, '2025-06-21 17:12:14.159935', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351446790434816, '2025-06-21 17:12:15.242921', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351451349643264, '2025-06-21 17:12:16.329368', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351460505808896, '2025-06-21 17:12:18.512407', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351465023074304, '2025-06-21 17:12:19.589858', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351469615837184, '2025-06-21 17:12:20.684275', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351474149879808, '2025-06-21 17:12:21.765413', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351478679728128, '2025-06-21 17:12:22.845818', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351483289268224, '2025-06-21 17:12:23.944095', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351487898808320, '2025-06-21 17:12:25.04318', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351492416073728, '2025-06-21 17:12:26.120798', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351497050779648, '2025-06-21 17:12:27.225368', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351514008350720, '2025-06-21 17:12:31.26856', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351518613696512, '2025-06-21 17:12:32.36644', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351548657496064, '2025-06-21 17:12:39.529923', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351565879308288, '2025-06-21 17:12:43.635929', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351570484654080, '2025-06-21 17:12:44.733434', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351575144525824, '2025-06-21 17:12:45.844295', 194232147738608, 'OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351579686957056, '2025-06-21 17:12:46.927417', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351584355217408, '2025-06-21 17:12:48.040665', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351588952174592, '2025-06-21 17:12:49.13639', 194232147738608, '$GNGSA,A,1,,,,,,20-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936351593691738112, '2025-06-21 17:12:50.266436', 194232147738608, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936351614885556224, '2025-06-21 17:12:55.319239', 194232147738608, '$GPTXT,01,01,02,IC=AT6558R-5N-32-1C580901*13');
INSERT INTO "public"."device_temp_data" VALUES (1936351619532845056, '2025-06-21 17:12:56.427069', 194232147738608, '$GPTXT,01,01,02,STXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351624113025024, '2025-06-21 17:12:57.519159', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351628684816384, '2025-06-21 17:12:58.609753', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351633264996352, '2025-06-21 17:12:59.701941', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351637857759232, '2025-06-21 17:13:00.796506', 194232147738608, '$GN');
INSERT INTO "public"."device_temp_data" VALUES (1936351642467299328, '2025-06-21 17:13:01.895876', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351647143948288, '2025-06-21 17:13:03.01015', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351651808014336, '2025-06-21 17:13:04.122416', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351656300113920, '2025-06-21 17:13:05.193892', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351660829962240, '2025-06-21 17:13:06.273085', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351665422725120, '2025-06-21 17:13:07.368693', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351669960962048, '2025-06-21 17:13:08.450438', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351674503393280, '2025-06-21 17:13:09.533029', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351679062601728, '2025-06-21 17:13:10.620683', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*');
INSERT INTO "public"."device_temp_data" VALUES (1936351683575672832, '2025-06-21 17:13:11.696719', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351688193601536, '2025-06-21 17:13:12.797203', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351692782170112, '2025-06-21 17:13:13.89197', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351697370738688, '2025-06-21 17:13:14.985707', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351701971890176, '2025-06-21 17:13:16.082741', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351706531098624, '2025-06-21 17:13:17.169739', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351711060946944, '2025-06-21 17:13:18.249122', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351715599183872, '2025-06-21 17:13:19.331868', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351720095477760, '2025-06-21 17:13:20.403275', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351724637908992, '2025-06-21 17:13:21.486534', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351729218088960, '2025-06-21 17:13:22.578306', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351733756325888, '2025-06-21 17:13:23.660921', 194232147738608, '$,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351738286174208, '2025-06-21 17:13:24.740618', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351742866354176, '2025-06-21 17:13:25.832078', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351747442339840, '2025-06-21 17:13:26.923555', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351751993159680, '2025-06-21 17:13:28.008077', 194232147738608, ',25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351756506230784, '2025-06-21 17:13:29.084283', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351761065439232, '2025-06-21 17:13:30.17185', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351765687562240, '2025-06-21 17:13:31.273673', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351770259353600, '2025-06-21 17:13:32.363663', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351774805979136, '2025-06-21 17:13:33.447069', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351779373576192, '2025-06-21 17:13:34.536343', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351783895035904, '2025-06-21 17:13:35.614744', 194232147738608, '$GNGG*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351788424884224, '2025-06-21 17:13:36.694649', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351793026035712, '2025-06-21 17:13:37.791829', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351797677518848, '2025-06-21 17:13:38.900766', 194232147738608, '$GNGGA,,,,,,0,00');
INSERT INTO "public"."device_temp_data" VALUES (1936351802173812736, '2025-06-21 17:13:39.972163', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351806733021184, '2025-06-21 17:13:41.05907', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351811359338496, '2025-06-21 17:13:42.162293', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351815918546944, '2025-06-21 17:13:43.249444', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351820452589568, '2025-06-21 17:13:44.330588', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351825007603712, '2025-06-21 17:13:45.416574', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351829529063424, '2025-06-21 17:13:46.4941', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351834075688960, '2025-06-21 17:13:47.578889', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351838601342976, '2025-06-21 17:13:48.65791', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351843164745728, '2025-06-21 17:13:49.745233', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351847686205440, '2025-06-21 17:13:50.823868', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351852190887936, '2025-06-21 17:13:51.897388', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351856699764736, '2025-06-21 17:13:52.97224', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351861263167488, '2025-06-21 17:13:54.06098', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351865818181632, '2025-06-21 17:13:55.146292', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351870427721728, '2025-06-21 17:13:56.2452', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936351875121147904, '2025-06-21 17:13:57.364082', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936351879772631040, '2025-06-21 17:13:58.47358', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936351884331839488, '2025-06-21 17:13:59.560867', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351888857493504, '2025-06-21 17:14:00.639069', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351893479616512, '2025-06-21 17:14:01.74179', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351898030436352, '2025-06-21 17:14:02.826114', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351902560284672, '2025-06-21 17:14:03.906611', 194232147738608, 'PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351907085938688, '2025-06-21 17:14:04.985467', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351911640952832, '2025-06-21 17:14:06.071182', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351916145635328, '2025-06-21 17:14:07.145118', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351920658706432, '2025-06-21 17:14:08.221155', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351925213720576, '2025-06-21 17:14:09.307054', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351929714208768, '2025-06-21 17:14:10.380683', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351934269222912, '2025-06-21 17:14:11.466344', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351938790682624, '2025-06-21 17:14:12.544456', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351943341502464, '2025-06-21 17:14:13.629739', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351947850379264, '2025-06-21 17:14:14.7041', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936351952447336448, '2025-06-21 17:14:15.800886', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351956977184768, '2025-06-21 17:14:16.880281', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351961507033088, '2025-06-21 17:14:17.960744', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351966066241536, '2025-06-21 17:14:19.047392', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936351970659004416, '2025-06-21 17:14:20.142393', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936351975197241344, '2025-06-21 17:14:21.224734', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936351979760644096, '2025-06-21 17:14:22.312254', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936351984311463936, '2025-06-21 17:14:23.397277', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936351988820340736, '2025-06-21 17:14:24.472501', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936351993371160576, '2025-06-21 17:14:25.55797', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936351997921980416, '2025-06-21 17:14:26.642406', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352002464411648, '2025-06-21 17:14:27.725918', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352007027814400, '2025-06-21 17:14:28.813091', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352011574439936, '2025-06-21 17:14:29.897144', 194232147738608, '$GPGSV,1,1,01,18,,,23,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936352016125259776, '2025-06-21 17:14:30.982324', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352020663496704, '2025-06-21 17:14:32.064076', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352025201733632, '2025-06-21 17:14:33.146724', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352029760942080, '2025-06-21 17:14:34.233395', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352034408230912, '2025-06-21 17:14:35.341089', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352038963245056, '2025-06-21 17:14:36.427124', 194232147738608, '$GNGGA,,,,,,0PGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352043526647808, '2025-06-21 17:14:37.515169', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352048048107520, '2025-06-21 17:14:38.593456', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352052649259008, '2025-06-21 17:14:39.690035', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352057279770624, '2025-06-21 17:14:40.794465', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352061901893632, '2025-06-21 17:14:41.896522', 194232147738608, '$GPTXT,01,01,01,ANTENNA ,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352066431741952, '2025-06-21 17:14:42.976404', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352070915452928, '2025-06-21 17:14:44.045752', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352075445301248, '2025-06-21 17:14:45.125205', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352080042258432, '2025-06-21 17:14:46.2211', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,,,,,,,,,,,,,,25.5,25.5,25.5,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352084681158656, '2025-06-21 17:14:47.327533', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352089194229760, '2025-06-21 17:14:48.403096', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352093761826816, '2025-06-21 17:14:49.49283', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352098270703616, '2025-06-21 17:14:50.567052', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352102796357632, '2025-06-21 17:14:51.646925', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352107292651520, '2025-06-21 17:14:52.718095', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352111902191616, '2025-06-21 17:14:53.817761', 194232147738608, '$GPGSV,1,1,01,23,,,19,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936352116503343104, '2025-06-21 17:14:54.914187', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352121054162944, '2025-06-21 17:14:55.999208', 194232147738608, '$GN*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936352125579816960, '2025-06-21 17:14:57.078425', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352130180968448, '2025-06-21 17:14:58.175773', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352134761148416, '2025-06-21 17:14:59.267473', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352139274219520, '2025-06-21 17:15:00.343393', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352143783096320, '2025-06-21 17:15:01.418904', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352148405219328, '2025-06-21 17:15:02.520249', 194232147738608, 'RMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352153056702464, '2025-06-21 17:15:03.62998', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352157561384960, '2025-06-21 17:15:04.70375', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352162166730752, '2025-06-21 17:15:05.801214', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352166696579072, '2025-06-21 17:15:06.881136', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352171247398912, '2025-06-21 17:15:07.966443', 194232147738608, '$GNGLL,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352175773052928, '2025-06-21 17:15:09.045399', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352180336455680, '2025-06-21 17:15:10.133361', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352184929218560, '2025-06-21 17:15:11.22867', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352189459066880, '2025-06-21 17:15:12.308081', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352193984720896, '2025-06-21 17:15:13.387783', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352198506180608, '2025-06-21 17:15:14.465962', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352203031834624, '2025-06-21 17:15:15.544644', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352207557488640, '2025-06-21 17:15:16.623474', 194232147738608, '$BTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352212112502784, '2025-06-21 17:15:17.70996', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,15,,,22,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936352216675905536, '2025-06-21 17:15:18.797347', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352221235113984, '2025-06-21 17:15:19.884614', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352225802711040, '2025-06-21 17:15:20.973223', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352230491942912, '2025-06-21 17:15:22.091023', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352235307003904, '2025-06-21 17:15:23.239755', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352239836852224, '2025-06-21 17:15:24.319121', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352244375089152, '2025-06-21 17:15:25.401048', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352248921714688, '2025-06-21 17:15:26.485059', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352253426397184, '2025-06-21 17:15:27.559763', 194232147738608, '$GNGSA*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352258002382848, '2025-06-21 17:15:28.650991', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352262536425472, '2025-06-21 17:15:29.731847', 194232147738608, '$GPT,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352267116605440, '2025-06-21 17:15:30.823824', 194232147738608, '$GPGSV,1,1,01,15,,,23,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936352271629676544, '2025-06-21 17:15:31.899529', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352276142747648, '2025-06-21 17:15:32.975329', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352280660013056, '2025-06-21 17:15:34.052712', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352285231804416, '2025-06-21 17:15:35.142107', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352289904259072, '2025-06-21 17:15:36.256001', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352294446690304, '2025-06-21 17:15:37.339865', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352298972344320, '2025-06-21 17:15:38.41895', 194232147738608, '$GNGLL,,,,,,V,N*7ASV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352303544135680, '2025-06-21 17:15:39.508616', 194232147738608, '$GNR,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352308073984000, '2025-06-21 17:15:40.588181', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352313090371584, '2025-06-21 17:15:41.784265', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352317687328768, '2025-06-21 17:15:42.880674', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352322238148608, '2025-06-21 17:15:43.965818', 194232147738608, '$GPGSV,1,1,01,29,,,18,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936352326830911488, '2025-06-21 17:15:45.060175', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352331381731328, '2025-06-21 17:15:46.145428', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352335882219520, '2025-06-21 17:15:47.218295', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352340504342528, '2025-06-21 17:15:48.320552', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352345038385152, '2025-06-21 17:15:49.401251', 194232147738608, '$GPTXT,01,01,01,ANTENNA ,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352349530484736, '2025-06-21 17:15:50.472437', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352354102276096, '2025-06-21 17:15:51.562824', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352358665678848, '2025-06-21 17:15:52.650586', 194232147738608, 'A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352363283607552, '2025-06-21 17:15:53.751567', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352367851204608, '2025-06-21 17:15:54.840961', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352372347498496, '2025-06-21 17:15:55.912514', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352376923484160, '2025-06-21 17:15:57.003154', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352381512052736, '2025-06-21 17:15:58.097791', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352386029318144, '2025-06-21 17:15:59.174719', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352390571749376, '2025-06-21 17:16:00.257399', 194232147738608, '5.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352395130957824, '2025-06-21 17:16:01.344259', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352399673389056, '2025-06-21 17:16:02.427908', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352404253569024, '2025-06-21 17:16:03.519087', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*3,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352408779223040, '2025-06-21 17:16:04.598995', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352413300682752, '2025-06-21 17:16:05.676035', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352417876668416, '2025-06-21 17:16:06.767377', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352422456848384, '2025-06-21 17:16:07.859717', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352426957336576, '2025-06-21 17:16:08.932611', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352431512350720, '2025-06-21 17:16:10.018431', 194232147738608, '$GNGSA,A,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936352436029616128, '2025-06-21 17:16:11.095585', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352440601407488, '2025-06-21 17:16:12.18516', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352445118672896, '2025-06-21 17:16:13.262408', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352449661104128, '2025-06-21 17:16:14.345785', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352454149009408, '2025-06-21 17:16:15.415271', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352458687246336, '2025-06-21 17:16:16.497975', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352463250649088, '2025-06-21 17:16:17.585641', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352467835023360, '2025-06-21 17:16:18.678743', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352472394231808, '2025-06-21 17:16:19.765179', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352476991188992, '2025-06-21 17:16:20.861646', 194232147738608, '$GNGLL,,,,,,V,N*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352481521037312, '2025-06-21 17:16:21.941806', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352486071857152, '2025-06-21 17:16:23.026068', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352490589122560, '2025-06-21 17:16:24.103225', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352495106387968, '2025-06-21 17:16:25.180413', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352499665596416, '2025-06-21 17:16:26.267936', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352505877360640, '2025-06-21 17:16:27.748415', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352513221586944, '2025-06-21 17:16:29.499061', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,');
INSERT INTO "public"."device_temp_data" VALUES (1936352517717880832, '2025-06-21 17:16:30.571287', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352522239340544, '2025-06-21 17:16:31.64935', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352531278065664, '2025-06-21 17:16:33.804992', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352535812108288, '2025-06-21 17:16:34.885291', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352540459397120, '2025-06-21 17:16:35.993381', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352544972468224, '2025-06-21 17:16:37.069419', 194232147738608, '$GPGSV,1,1,02,03,,,22,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352549498122240, '2025-06-21 17:16:38.14806', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352554040553472, '2025-06-21 17:16:39.231196', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352558608150528, '2025-06-21 17:16:40.320961', 194232147738608, '$GNVTG,,,2,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352563226079232, '2025-06-21 17:16:41.421673', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352567848202240, '2025-06-21 17:16:42.523202', 194232147738608, '$GNRMC,,VGNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352572399022080, '2025-06-21 17:16:43.608909', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352576933064704, '2025-06-21 17:16:44.68966', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352581446135808, '2025-06-21 17:16:45.765852', 194232147738608, '$GPGSV,1,1,01,197,,,23,0*5A');
INSERT INTO "public"."device_temp_data" VALUES (1936352585996955648, '2025-06-21 17:16:46.850943', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352590526803968, '2025-06-21 17:16:47.93011', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352595106983936, '2025-06-21 17:16:49.022737', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352599670386688, '2025-06-21 17:16:50.110703', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352604221206528, '2025-06-21 17:16:51.195267', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352608746860544, '2025-06-21 17:16:52.274811', 194232147738608, '$G.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352613301874688, '2025-06-21 17:16:53.36048', 194232147738608, '$GPGSV,1,1,01,197,,,23,0*ZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352617852694528, '2025-06-21 17:16:54.445034', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352622390931456, '2025-06-21 17:16:55.527159', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352626924974080, '2025-06-21 17:16:56.608903', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352631479988224, '2025-06-21 17:16:57.694073', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352636022419456, '2025-06-21 17:16:58.777398', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352641223356416, '2025-06-21 17:17:00.017565', 194232147738608, '$GPGSV,1,1,01,197,,,23,0*5A');
INSERT INTO "public"."device_temp_data" VALUES (1936352645782564864, '2025-06-21 17:17:01.104596', 194232147738608, '$BDGSVA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352650362744832, '2025-06-21 17:17:02.196554', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352654880010240, '2025-06-21 17:17:03.273561', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352659393081344, '2025-06-21 17:17:04.349947', 194232147738608, '$GNGSA,A,1,,,,,,,,,25');
INSERT INTO "public"."device_temp_data" VALUES (1936352663990038528, '2025-06-21 17:17:05.445718', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352668549246976, '2025-06-21 17:17:06.532506', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352673074900992, '2025-06-21 17:17:07.611155', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352677642498048, '2025-06-21 17:17:08.700866', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352682193317888, '2025-06-21 17:17:09.785589', 194232147738608, '$GPGSV,1,1,02,28,,,26,30,,,24,TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352686706388992, '2025-06-21 17:17:10.861176', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352691240431616, '2025-06-21 17:17:11.942033', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352695795445760, '2025-06-21 17:17:13.028832', 194232147738608, '$GNGGA,,,,,,0,00,25.37');
INSERT INTO "public"."device_temp_data" VALUES (1936352700425957376, '2025-06-21 17:17:14.132561', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352704989360128, '2025-06-21 17:17:15.220959', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352709548568576, '2025-06-21 17:17:16.307044', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352714107777024, '2025-06-21 17:17:17.394035', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352718687956992, '2025-06-21 17:17:18.48638', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352723205222400, '2025-06-21 17:17:19.563503', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*011,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352727730876416, '2025-06-21 17:17:20.642063', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352732285890560, '2025-06-21 17:17:21.728534', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352736874459136, '2025-06-21 17:17:22.822987', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352741395918848, '2025-06-21 17:17:23.900391', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352745896407040, '2025-06-21 17:17:24.973777', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352750384312320, '2025-06-21 17:17:26.043997', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352754922549248, '2025-06-21 17:17:27.125057', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352759464980480, '2025-06-21 17:17:28.208967', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352763994828800, '2025-06-21 17:17:29.288634', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352768545648640, '2025-06-21 17:17:30.373339', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352773092274176, '2025-06-21 17:17:31.457078', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352777802477568, '2025-06-21 17:17:32.580394', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352782374268928, '2025-06-21 17:17:33.670234', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352788053356544, '2025-06-21 17:17:35.024748', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352792545456128, '2025-06-21 17:17:36.095145', 194232147738608, '$GPGSV,1,1,03,14,,,22,16,,,20,28,,,26,0*,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352797134024704, '2025-06-21 17:17:37.189703', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352806147584000, '2025-06-21 17:17:39.338374', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352812548091904, '2025-06-21 17:17:40.864177', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352817249906688, '2025-06-21 17:17:41.985958', 194232147738608, ',,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352821947527168, '2025-06-21 17:17:43.105461', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352826510929920, '2025-06-21 17:17:44.193602', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352831200161792, '2025-06-21 17:17:45.311436', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352835922948096, '2025-06-21 17:17:46.437513', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352840587014144, '2025-06-21 17:17:47.549342', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352845158805504, '2025-06-21 17:17:48.639829', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.1,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352849843843072, '2025-06-21 17:17:49.756156', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352854403051520, '2025-06-21 17:17:50.843274', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352858911928320, '2025-06-21 17:17:51.918469', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352863458553856, '2025-06-21 17:17:53.002634', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352868005179392, '2025-06-21 17:17:54.086445', 194232147738608, '$GPGSV,1,11*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352872564387840, '2025-06-21 17:17:55.173021', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352877115207680, '2025-06-21 17:17:56.258194', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936352881661833216, '2025-06-21 17:17:57.342384', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936352886401396736, '2025-06-21 17:17:58.472602', 194232147738608, '$GNRMC,,V,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936352890935439360, '2025-06-21 17:17:59.553653', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352895498842112, '2025-06-21 17:18:00.641931', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352900125159424, '2025-06-21 17:18:01.744418', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352904608870400, '2025-06-21 17:18:02.813826', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352909172273152, '2025-06-21 17:18:03.901407', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352913723092992, '2025-06-21 17:18:04.986173', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,, OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352918294884352, '2025-06-21 17:18:06.07632', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352922799566848, '2025-06-21 17:18:07.150624', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352927442661376, '2025-06-21 17:18:08.257655', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,21,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352931993481216, '2025-06-21 17:18:09.342615', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352936552689664, '2025-06-21 17:18:10.429664', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352941153841152, '2025-06-21 17:18:11.526313', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352945666912256, '2025-06-21 17:18:12.602507', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352950167400448, '2025-06-21 17:18:13.675248', 194232147738608, '$GPGSV,1,1,01,28,,,26,');
INSERT INTO "public"."device_temp_data" VALUES (1936352954684665856, '2025-06-21 17:18:14.752818', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352959252262912, '2025-06-21 17:18:15.841548', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352963819859968, '2025-06-21 17:18:16.93089', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936352968366485504, '2025-06-21 17:18:18.014905', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936352972925693952, '2025-06-21 17:18:19.101184', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936352977484902400, '2025-06-21 17:18:20.188473', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936352982081859584, '2025-06-21 17:18:21.284977', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936352986670428160, '2025-06-21 17:18:22.378795', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936352991196082176, '2025-06-21 17:18:23.457343', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936352995730124800, '2025-06-21 17:18:24.538978', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353000289333248, '2025-06-21 17:18:25.625867', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353004835958784, '2025-06-21 17:18:26.709488', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353009370001408, '2025-06-21 17:18:27.790469', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353013925015552, '2025-06-21 17:18:28.876494', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353018429698048, '2025-06-21 17:18:29.950668', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353022976323584, '2025-06-21 17:18:31.034436', 194232147738608, 'SV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353027522949120, '2025-06-21 17:18:32.118005', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353032052797440, '2025-06-21 17:18:33.198389', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353037140488192, '2025-06-21 17:18:34.41153', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353041691308032, '2025-06-21 17:18:35.496037', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353046191796224, '2025-06-21 17:18:36.569467', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353050717450240, '2025-06-21 17:18:37.648963', 194232147738608, '$GN*59');
INSERT INTO "public"."device_temp_data" VALUES (1936353055259881472, '2025-06-21 17:18:38.731533', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353059823284224, '2025-06-21 17:18:39.819794', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353064411852800, '2025-06-21 17:18:40.91391', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353069013004288, '2025-06-21 17:18:42.010519', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353073526075392, '2025-06-21 17:18:43.086927', 194232147738608, '$GPTXT,01,5.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353078072700928, '2025-06-21 17:18:44.170212', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353082631909376, '2025-06-21 17:18:45.257909', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353087249838080, '2025-06-21 17:18:46.358347', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353093453213696, '2025-06-21 17:18:47.837747', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353098045976576, '2025-06-21 17:18:48.932438', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353102655516672, '2025-06-21 17:18:50.031335', 194232147738608, '$GNZDA,,,,NVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353107235696640, '2025-06-21 17:18:51.12358', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353111794905088, '2025-06-21 17:18:52.210226', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*2EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353116337336320, '2025-06-21 17:18:53.293808', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353120888156160, '2025-06-21 17:18:54.378303', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353125443170304, '2025-06-21 17:18:55.464103', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353129989795840, '2025-06-21 17:18:56.548784', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353134620307456, '2025-06-21 17:18:57.652311', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353139187904512, '2025-06-21 17:18:58.741144', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353143688392704, '2025-06-21 17:18:59.814029', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353148205658112, '2025-06-21 17:19:00.89167', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353152689369088, '2025-06-21 17:19:01.960749', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353157235994624, '2025-06-21 17:19:03.044666', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353166337634304, '2025-06-21 17:19:05.214728', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353170917814272, '2025-06-21 17:19:06.30675', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353175464439808, '2025-06-21 17:19:07.390136', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353180006871040, '2025-06-21 17:19:08.473083', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353184536719360, '2025-06-21 17:19:09.553412', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353189095927808, '2025-06-21 17:19:10.640649', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353193629970432, '2025-06-21 17:19:11.721348', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353198218539008, '2025-06-21 17:19:12.815336', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353202748387328, '2025-06-21 17:19:13.895147', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353207232098304, '2025-06-21 17:19:14.964938', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353211782918144, '2025-06-21 17:19:16.049248', 194232147738608, '$GNGGA,,,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353216337932288, '2025-06-21 17:19:17.135702', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353220884557824, '2025-06-21 17:19:18.219393', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353225473126400, '2025-06-21 17:19:19.313572', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353230011363328, '2025-06-21 17:19:20.395425', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353234553794560, '2025-06-21 17:19:21.478136', 194232147738608, '$GNGLL,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353239209472000, '2025-06-21 17:19:22.588189', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353243743514624, '2025-06-21 17:19:23.669557', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353248290140160, '2025-06-21 17:19:24.753483', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353252882903040, '2025-06-21 17:19:25.848474', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353257379196928, '2025-06-21 17:19:26.920929', 194232147738608, '$GNGSA,A,1,,,,,,GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353261921628160, '2025-06-21 17:19:28.003313', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353266409533440, '2025-06-21 17:19:29.073397', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353270943576064, '2025-06-21 17:19:30.15422', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353275490201600, '2025-06-21 17:19:31.238434', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353280028438528, '2025-06-21 17:19:32.320204', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353284562481152, '2025-06-21 17:19:33.401354', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353289096523776, '2025-06-21 17:19:34.482349', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353293634760704, '2025-06-21 17:19:35.56449', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353298181386240, '2025-06-21 17:19:36.648909', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353302686068736, '2025-06-21 17:19:37.722834', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353307232694272, '2025-06-21 17:19:38.806402', 194232147738608, '$GNGLL,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936353311779319808, '2025-06-21 17:19:39.89061', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353316367888384, '2025-06-21 17:19:40.984661', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353321036148736, '2025-06-21 17:19:42.097835', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353325532442624, '2025-06-21 17:19:43.169638', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353330091651072, '2025-06-21 17:19:44.256413', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353334571167744, '2025-06-21 17:19:45.324639', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353339084238848, '2025-06-21 17:19:46.400663', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353343597309952, '2025-06-21 17:19:47.476274', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353348177489920, '2025-06-21 17:19:48.568814', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353352740892672, '2025-06-21 17:19:49.656358', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353357266546688, '2025-06-21 17:19:50.735048', 194232147738608, 'NGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353361813172224, '2025-06-21 17:19:51.819052', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353366355603456, '2025-06-21 17:19:52.902778', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353370898034688, '2025-06-21 17:19:53.985307', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353375411105792, '2025-06-21 17:19:55.061708', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353379991285760, '2025-06-21 17:19:56.153532', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353384512745472, '2025-06-21 17:19:57.231519', 194232147738608, '$GNVTG,,,,,,,,,NRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353389046788096, '2025-06-21 17:19:58.31224', 194232147738608, '$GNVTG,,,,,,,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936353393593413632, '2025-06-21 17:19:59.396031', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353398106484736, '2025-06-21 17:20:00.472353', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353402674081792, '2025-06-21 17:20:01.561839', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353407187152896, '2025-06-21 17:20:02.637651', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353411691835392, '2025-06-21 17:20:03.711852', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353416230072320, '2025-06-21 17:20:04.793591', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353420755726336, '2025-06-21 17:20:05.872094', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353425235243008, '2025-06-21 17:20:06.940924', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353429790257152, '2025-06-21 17:20:08.026694', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353434341076992, '2025-06-21 17:20:09.111803', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353438875119616, '2025-06-21 17:20:10.192413', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353443425939456, '2025-06-21 17:20:11.277924', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353448643653632, '2025-06-21 17:20:12.521335', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353453169307648, '2025-06-21 17:20:13.600697', 194232147738608, '$GNGGA,,');
INSERT INTO "public"."device_temp_data" VALUES (1936353459775336448, '2025-06-21 17:20:15.175192', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353464275824640, '2025-06-21 17:20:16.248537', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353468788895744, '2025-06-21 17:20:17.324121', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353473301966848, '2025-06-21 17:20:18.400432', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353477810843648, '2025-06-21 17:20:19.475359', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353482336497664, '2025-06-21 17:20:20.554294', 194232147738608, '$GNGSA,A,1,,A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353486912483328, '2025-06-21 17:20:21.64572', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353491471691776, '2025-06-21 17:20:22.732516', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353496106397696, '2025-06-21 17:20:23.837656', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353500632051712, '2025-06-21 17:20:24.916026', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353505317089280, '2025-06-21 17:20:26.033632', 194232147738608, '$GPGSV,1,1,01,13,,,22,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936353509880492032, '2025-06-21 17:20:27.121186', 194232147738608, '$BDGSV,1,1,00,NGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353514460672000, '2025-06-21 17:20:28.213404', 194232147738608, '$GPGSV,1,1,01,13,,,22A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353519028269056, '2025-06-21 17:20:29.302096', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353523562311680, '2025-06-21 17:20:30.383406', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353528134103040, '2025-06-21 17:20:31.473351', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353532605231104, '2025-06-21 17:20:32.539733', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353537147662336, '2025-06-21 17:20:33.622879', 194232147738608, '$GPGSV,1,1,01,04,,,22,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936353541736230912, '2025-06-21 17:20:34.716811', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353546287050752, '2025-06-21 17:20:35.801369', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353550871425024, '2025-06-21 17:20:36.894474', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353555380301824, '2025-06-21 17:20:37.96994', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353559947898880, '2025-06-21 17:20:39.058835', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353564570021888, '2025-06-21 17:20:40.160827', 194232147738608, ',,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353569108258816, '2025-06-21 17:20:41.242554', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353573663272960, '2025-06-21 17:20:42.328379', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353578218287104, '2025-06-21 17:20:43.414421', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353582769106944, '2025-06-21 17:20:44.499011', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353587366064128, '2025-06-21 17:20:45.595278', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353591912689664, '2025-06-21 17:20:46.679084', 194232147738608, '$GNGSA,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353596467703808, '2025-06-21 17:20:47.765827', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353601018523648, '2025-06-21 17:20:48.850325', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353605699366912, '2025-06-21 17:20:49.966184', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353610245992448, '2025-06-21 17:20:51.05077', 194232147738608, 'NGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353614821978112, '2025-06-21 17:20:52.141784', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353619368603648, '2025-06-21 17:20:53.225866', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353623919423488, '2025-06-21 17:20:54.310164', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353628466049024, '2025-06-21 17:20:55.394118', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353632987508736, '2025-06-21 17:20:56.47236', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353637487996928, '2025-06-21 17:20:57.545779', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPENA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353642026233856, '2025-06-21 17:20:58.627025', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353646564470784, '2025-06-21 17:20:59.709758', 194232147738608, '$GN5.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353651098513408, '2025-06-21 17:21:00.790059', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353655645138944, '2025-06-21 17:21:01.874169', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353660242096128, '2025-06-21 17:21:02.970214', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353664767750144, '2025-06-21 17:21:04.049046', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353669289209856, '2025-06-21 17:21:05.127233', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353673856806912, '2025-06-21 17:21:06.216301', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353678390849536, '2025-06-21 17:21:07.297769', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353682941669376, '2025-06-21 17:21:08.382902', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353687484100608, '2025-06-21 17:21:09.465128', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353691988783104, '2025-06-21 17:21:10.539336', 194232147738608, '$GNGS,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353696497659904, '2025-06-21 17:21:11.614085', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353701052674048, '2025-06-21 17:21:12.700796', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353705645436928, '2025-06-21 17:21:13.795904', 194232147738608, '$GPTXT,01,01,01,ANTV,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353710145925120, '2025-06-21 17:21:14.86886', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353714717716480, '2025-06-21 17:21:15.958341', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353719524388864, '2025-06-21 17:21:17.104435', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936353724352032768, '2025-06-21 17:21:18.255665', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353729964011520, '2025-06-21 17:21:19.593456', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353734791655424, '2025-06-21 17:21:20.744463', 194232147738608, '$GNVTG,,,,,,,,,N*1,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353850701246464, '2025-06-21 17:21:48.379776', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353855239483392, '2025-06-21 17:21:49.461234', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353859756748800, '2025-06-21 17:21:50.538733', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353864441786368, '2025-06-21 17:21:51.65563', 194232147738608, '$GPTXT,01,0,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353869546254336, '2025-06-21 17:21:52.872513', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353874088685568, '2025-06-21 17:21:53.954501', 194232147738608, '$GPGSV,1,1,01,193,,,22,0*5F');
INSERT INTO "public"."device_temp_data" VALUES (1936353878593368064, '2025-06-21 17:21:55.029231', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353883152576512, '2025-06-21 17:21:56.116584', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353887682424832, '2025-06-21 17:21:57.19631', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936353892187107328, '2025-06-21 17:21:58.270329', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353896771481600, '2025-06-21 17:21:59.363863', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353901284552704, '2025-06-21 17:22:00.439734', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353905797623808, '2025-06-21 17:22:01.515289', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353910298112000, '2025-06-21 17:22:02.588044', 194232147738608, '$GNGSAXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353914827960320, '2025-06-21 17:22:03.668761', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353919332642816, '2025-06-21 17:22:04.742991', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353923841519616, '2025-06-21 17:22:05.817054', 194232147738608, '$GNGSA,A,LL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353928379756544, '2025-06-21 17:22:06.899807', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353932892827648, '2025-06-21 17:22:07.975078', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353937456230400, '2025-06-21 17:22:09.06383', 194232147738608, '$GPGSV,1,1,02,07,,,23,193,,,21,0*59');
INSERT INTO "public"."device_temp_data" VALUES (1936353941965107200, '2025-06-21 17:22:10.138436', 194232147738608, '$BDGSV,1,1,01,07,,,23,0*7ZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936353946515927040, '2025-06-21 17:22:11.223828', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936353951079329792, '2025-06-21 17:22:12.311445', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353955584012288, '2025-06-21 17:22:13.385156', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353960139026432, '2025-06-21 17:22:14.471243', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936353964647903232, '2025-06-21 17:22:15.54604', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936353969156780032, '2025-06-21 17:22:16.621988', 194232147738608, '$GPGSV,1,1,01,0');
INSERT INTO "public"."device_temp_data" VALUES (1936353973665656832, '2025-06-21 17:22:17.696794', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936353978254225408, '2025-06-21 17:22:18.79018', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936353982763102208, '2025-06-21 17:22:19.86532', 194232147738608, 'PGSV,1,1,01,19,,,21,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936353987276173312, '2025-06-21 17:22:20.941397', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936353991843770368, '2025-06-21 17:22:22.030071', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936353996394590208, '2025-06-21 17:22:23.115402', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354000924438528, '2025-06-21 17:22:24.195232', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354005416538112, '2025-06-21 17:22:25.266347', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354009950580736, '2025-06-21 17:22:26.347619', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354014501400576, '2025-06-21 17:22:27.432348', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354019031248896, '2025-06-21 17:22:28.512596', 194232147738608, '$GNGSA,A,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936354023523348480, '2025-06-21 17:22:29.583819', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354028137082880, '2025-06-21 17:22:30.683196', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354032725651456, '2025-06-21 17:22:31.777279', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354037234528256, '2025-06-21 17:22:32.852881', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354041818902528, '2025-06-21 17:22:33.945045', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354046323585024, '2025-06-21 17:22:35.01953', 194232147738608, ',,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354050849239040, '2025-06-21 17:22:36.098107', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354055395864576, '2025-06-21 17:22:37.182127', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354059917324288, '2025-06-21 17:22:38.260311', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354064476532736, '2025-06-21 17:22:39.347582', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*GSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354069056712704, '2025-06-21 17:22:40.439085', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354073695612928, '2025-06-21 17:22:41.545488', 194232147738608, '$GNVTG,,$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354078351290368, '2025-06-21 17:22:42.655658', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354082985996288, '2025-06-21 17:22:43.760041', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354087494873088, '2025-06-21 17:22:44.835095', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354092075053056, '2025-06-21 17:22:45.927144', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354096646844416, '2025-06-21 17:22:47.017732', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354101227024384, '2025-06-21 17:22:48.109414', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354105756872704, '2025-06-21 17:22:49.189654', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354110316081152, '2025-06-21 17:22:50.276577', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354114829152256, '2025-06-21 17:22:51.352071', 194232147738608, 'DGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354119400943616, '2025-06-21 17:22:52.442312', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354123939180544, '2025-06-21 17:22:53.524425', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354128485806080, '2025-06-21 17:22:54.608347', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354133082763264, '2025-06-21 17:22:55.704609', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354137616805888, '2025-06-21 17:22:56.785645', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354142142459904, '2025-06-21 17:22:57.864887', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354146621976576, '2025-06-21 17:22:58.932809', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354151176990720, '2025-06-21 17:23:00.01812', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354155815890944, '2025-06-21 17:23:01.124526', 194232147738608, ',0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936354160438013952, '2025-06-21 17:23:02.226163', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354164976250880, '2025-06-21 17:23:03.308269', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354169522876416, '2025-06-21 17:23:04.392719', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354174052724736, '2025-06-21 17:23:05.472866', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354178532241408, '2025-06-21 17:23:06.540585', 194232147738608, '$GPTXT,01,01,01,ANTENNA O');
INSERT INTO "public"."device_temp_data" VALUES (1936354183053701120, '2025-06-21 17:23:07.618032', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354187600326656, '2025-06-21 17:23:08.702764', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354192134369280, '2025-06-21 17:23:09.783151', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354196630663168, '2025-06-21 17:23:10.855581', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354201202454528, '2025-06-21 17:23:11.945052', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354205715525632, '2025-06-21 17:23:13.021829', 194232147738608, '$GNGGA,,,,,,0,00,25A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354210241179648, '2025-06-21 17:23:14.100393', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354214800388096, '2025-06-21 17:23:15.187091', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354219351207936, '2025-06-21 17:23:16.272765', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354223885250560, '2025-06-21 17:23:17.353594', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354228419293184, '2025-06-21 17:23:18.434966', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354232940752896, '2025-06-21 17:23:19.512887', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354237441241088, '2025-06-21 17:23:20.585956', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354242025615360, '2025-06-21 17:23:21.678133', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354246576435200, '2025-06-21 17:23:22.763432', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354251152420864, '2025-06-21 17:23:23.854795', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354255703240704, '2025-06-21 17:23:24.939164', 194232147738608, ',,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354260191145984, '2025-06-21 17:23:26.009745', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354264762937344, '2025-06-21 17:23:27.099566', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354269347311616, '2025-06-21 17:23:28.192792', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354273889742848, '2025-06-21 17:23:29.275865', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354278419591168, '2025-06-21 17:23:30.355044', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354282920079360, '2025-06-21 17:23:31.428084', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354287491870720, '2025-06-21 17:23:32.518057', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354292042690560, '2025-06-21 17:23:33.603299', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354296585121792, '2025-06-21 17:23:34.686037', 194232147738608, ',,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354301123358720, '2025-06-21 17:23:35.768684', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354305640624128, '2025-06-21 17:23:36.845945', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354310149500928, '2025-06-21 17:23:37.920254', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354314725486592, '2025-06-21 17:23:39.011187', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354319372775424, '2025-06-21 17:23:40.119274', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354323982315520, '2025-06-21 17:23:41.218639', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354328524746752, '2025-06-21 17:23:42.301516', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354333071372288, '2025-06-21 17:23:43.385232', 194232147738608, '$GNGGA,04');
INSERT INTO "public"."device_temp_data" VALUES (1936354337576054784, '2025-06-21 17:23:44.459752', 194232147738608, '$GPGSV,1,1,0NZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354342105903104, '2025-06-21 17:23:45.539868', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354346665111552, '2025-06-21 17:23:46.626717', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354351207542784, '2025-06-21 17:23:47.709968', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354355775139840, '2025-06-21 17:23:48.798543', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354360359514112, '2025-06-21 17:23:49.891706', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354364935499776, '2025-06-21 17:23:50.982183', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354369435987968, '2025-06-21 17:23:52.055546', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354373970030592, '2025-06-21 17:23:53.13654', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354378550210560, '2025-06-21 17:23:54.228358', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354383109419008, '2025-06-21 17:23:55.31556', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354387677016064, '2025-06-21 17:23:56.404804', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354392227835904, '2025-06-21 17:23:57.489396', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936354396795432960, '2025-06-21 17:23:58.578485', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354401363030016, '2025-06-21 17:23:59.66719', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354405939015680, '2025-06-21 17:24:00.758497', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354410426920960, '2025-06-21 17:24:01.828771', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354414969352192, '2025-06-21 17:24:02.911529', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354419557920768, '2025-06-21 17:24:04.005096', 194232147738608, '$GNGSA,A,1,,,,,PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354424133906432, '2025-06-21 17:24:05.096576', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354428726669312, '2025-06-21 17:24:06.191022', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354433248129024, '2025-06-21 17:24:07.269269', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354437798948864, '2025-06-21 17:24:08.354237', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354442332991488, '2025-06-21 17:24:09.435623', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354446913171456, '2025-06-21 17:24:10.527209', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354452332212224, '2025-06-21 17:24:11.819971', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354457155661824, '2025-06-21 17:24:12.969628', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354461689704448, '2025-06-21 17:24:14.050093', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354466227941376, '2025-06-21 17:24:15.13206', 194232147738608, '$GPTXT,01,01N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354470766178304, '2025-06-21 17:24:16.214612', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354475337969664, '2025-06-21 17:24:17.304395', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354479943315456, '2025-06-21 17:24:18.402322', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354484502523904, '2025-06-21 17:24:19.489276', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354489032372224, '2025-06-21 17:24:20.56998', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354493558026240, '2025-06-21 17:24:21.648068', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354498842849280, '2025-06-21 17:24:22.908572', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354503423029248, '2025-06-21 17:24:24.000522', 194232147738608, '$GPGSPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354507931906048, '2025-06-21 17:24:25.075057', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354512432394240, '2025-06-21 17:24:26.148843', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354517020962816, '2025-06-21 17:24:27.242115', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354521571782656, '2025-06-21 17:24:28.327064', 194232147738608, '$GNGSA,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354526168739840, '2025-06-21 17:24:29.423805', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354530711171072, '2025-06-21 17:24:30.506925', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354535299739648, '2025-06-21 17:24:31.600765', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354539867336704, '2025-06-21 17:24:32.689644', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354544527208448, '2025-06-21 17:24:33.800069', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354549073833984, '2025-06-21 17:24:34.884101', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354553607876608, '2025-06-21 17:24:35.965759', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354558171279360, '2025-06-21 17:24:37.053142', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354562722099200, '2025-06-21 17:24:38.138174', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354567314862080, '2025-06-21 17:24:39.233978', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354571911819264, '2025-06-21 17:24:40.329977', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354576533942272, '2025-06-21 17:24:41.431856', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354581097345024, '2025-06-21 17:24:42.51991', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354585635581952, '2025-06-21 17:24:43.601484', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354590123487232, '2025-06-21 17:24:44.671706', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354594678501376, '2025-06-21 17:24:45.757324', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354599187378176, '2025-06-21 17:24:46.832201', 194232147738608, '$GPGSV,1,1,01,195,,,2*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354603725615104, '2025-06-21 17:24:47.91469', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354608276434944, '2025-06-21 17:24:48.999183', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354612806283264, '2025-06-21 17:24:50.079138', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354617340325888, '2025-06-21 17:24:51.160821', 194232147738608, '$GNGLL,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354621845008384, '2025-06-21 17:24:52.234652', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354626429382656, '2025-06-21 17:24:53.32746', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354630988591104, '2025-06-21 17:24:54.414566', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354635531022336, '2025-06-21 17:24:55.497006', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354640132173824, '2025-06-21 17:24:56.594498', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354644724936704, '2025-06-21 17:24:57.689468', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354649271562240, '2025-06-21 17:24:58.773049', 194232147738608, '$BDGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354653818187776, '2025-06-21 17:24:59.857566', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354658360619008, '2025-06-21 17:25:00.94013', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354662890467328, '2025-06-21 17:25:02.020754', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354667437092864, '2025-06-21 17:25:03.104195', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354671966941184, '2025-06-21 17:25:04.184654', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354676500983808, '2025-06-21 17:25:05.265121', 194232147738608, 'PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354681051803648, '2025-06-21 17:25:06.350379', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354685594234880, '2025-06-21 17:25:07.433939', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354690161831936, '2025-06-21 17:25:08.522493', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354694683291648, '2025-06-21 17:25:09.600047', 194232147738608, '$GNGSA,G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354699171196928, '2025-06-21 17:25:10.670666', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354703667490816, '2025-06-21 17:25:11.742431', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354708197339136, '2025-06-21 17:25:12.822057', 194232147738608, 'NGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354712706215936, '2025-06-21 17:25:13.897025', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354717257035776, '2025-06-21 17:25:14.982028', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354721816244224, '2025-06-21 17:25:16.069421', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354726350286848, '2025-06-21 17:25:17.150221', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354730880135168, '2025-06-21 17:25:18.230573', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354735409983488, '2025-06-21 17:25:19.310332', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354739964997632, '2025-06-21 17:25:20.396872', 194232147738608, '$GNGGA,,,,,XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354744549371904, '2025-06-21 17:25:21.489102', 194232147738608, '$GNGGA1,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354749104386048, '2025-06-21 17:25:22.575486', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354753680371712, '2025-06-21 17:25:23.666902', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354758222802944, '2025-06-21 17:25:24.749279', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354762735874048, '2025-06-21 17:25:25.825502', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354767320248320, '2025-06-21 17:25:26.918661', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354771879456768, '2025-06-21 17:25:28.005016', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354776375750656, '2025-06-21 17:25:29.077449', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354781002067968, '2025-06-21 17:25:30.18072', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354785552887808, '2025-06-21 17:25:31.265408', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354790086930432, '2025-06-21 17:25:32.346869', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354794696470528, '2025-06-21 17:25:33.445148', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354799243096064, '2025-06-21 17:25:34.529046', 194232147738608, '$GNGLL,,,,,,V,N*7');
INSERT INTO "public"."device_temp_data" VALUES (1936354803781332992, '2025-06-21 17:25:35.611354', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354808298598400, '2025-06-21 17:25:36.688136', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354812832641024, '2025-06-21 17:25:37.769636', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354817362489344, '2025-06-21 17:25:38.849769', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354821951057920, '2025-06-21 17:25:39.943325', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936354826552209408, '2025-06-21 17:25:41.04078', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354831191109632, '2025-06-21 17:25:42.14647', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354835796455424, '2025-06-21 17:25:43.244465', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354840385024000, '2025-06-21 17:25:44.338588', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354844914872320, '2025-06-21 17:25:45.418103', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354854003929088, '2025-06-21 17:25:47.585508', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354858550554624, '2025-06-21 17:25:48.669016', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354863130734592, '2025-06-21 17:25:49.761221', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354867685748736, '2025-06-21 17:25:50.847436', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354872278511616, '2025-06-21 17:25:51.942756', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,RMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354876833525760, '2025-06-21 17:25:53.028811', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354881384345600, '2025-06-21 17:25:54.113605', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354885943554048, '2025-06-21 17:25:55.200256', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354890506956800, '2025-06-21 17:25:56.288081', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354895061970944, '2025-06-21 17:25:57.374993', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354899600207872, '2025-06-21 17:25:58.456277', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936354904163610624, '2025-06-21 17:25:59.544684', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354908752179200, '2025-06-21 17:26:00.638253', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354913319776256, '2025-06-21 17:26:01.727545', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354917832847360, '2025-06-21 17:26:02.803179', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354922379472896, '2025-06-21 17:26:03.887699', 194232147738608, ',,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354926926098432, '2025-06-21 17:26:04.971283', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354931523055616, '2025-06-21 17:26:06.067013', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354936090652672, '2025-06-21 17:26:07.156189', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354940586946560, '2025-06-21 17:26:08.228697', 194232147738608, '$GPGSV,1,1,00,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354945108406272, '2025-06-21 17:26:09.306729', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354949705363456, '2025-06-21 17:26:10.402283', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936354954310709248, '2025-06-21 17:26:11.500075', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354958857334784, '2025-06-21 17:26:12.584891', 194232147738608, 'GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936354963424931840, '2025-06-21 17:26:13.673013', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936354968017694720, '2025-06-21 17:26:14.768793', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354972593680384, '2025-06-21 17:26:15.859171', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354977182248960, '2025-06-21 17:26:16.953887', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936354981716291584, '2025-06-21 17:26:18.034632', 194232147738608, '$,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936354986258722816, '2025-06-21 17:26:19.117002', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936354990855680000, '2025-06-21 17:26:20.213942', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936354995364556800, '2025-06-21 17:26:21.288829', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936354999881822208, '2025-06-21 17:26:22.365809', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355004420059136, '2025-06-21 17:26:23.447005', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355008966684672, '2025-06-21 17:26:24.53125', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355014473805824, '2025-06-21 17:26:25.844734', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355019318226944, '2025-06-21 17:26:26.999944', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355024250728448, '2025-06-21 17:26:28.175448', 194232147738608, '$GNGSA,A,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355028847685632, '2025-06-21 17:26:29.271491', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355033457225728, '2025-06-21 17:26:30.37066', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355037995462656, '2025-06-21 17:26:31.4527', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355042579836928, '2025-06-21 17:26:32.545795', 194232147738608, ',0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355047172599808, '2025-06-21 17:26:33.640281', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355051689865216, '2025-06-21 17:26:34.717586', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355056295211008, '2025-06-21 17:26:35.815532', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355060837642240, '2025-06-21 17:26:36.898003', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355065409433600, '2025-06-21 17:26:37.988454', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355069956059136, '2025-06-21 17:26:39.072022', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355074599153664, '2025-06-21 17:26:40.179406', 194232147738608, '$GNGSA,A,1,,,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355079271608320, '2025-06-21 17:26:41.293312', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355083851788288, '2025-06-21 17:26:42.38587', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*6A,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355088427773952, '2025-06-21 17:26:43.476005', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355092949233664, '2025-06-21 17:26:44.554961', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355097521025024, '2025-06-21 17:26:45.644186', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355102105399296, '2025-06-21 17:26:46.737216', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355106698162176, '2025-06-21 17:26:47.832687', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355111295119360, '2025-06-21 17:26:48.92834', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936355115862716416, '2025-06-21 17:26:50.017144', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355120409341952, '2025-06-21 17:26:51.101114', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355125027270656, '2025-06-21 17:26:52.202621', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355129573896192, '2025-06-21 17:26:53.286084', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355134112133120, '2025-06-21 17:26:54.368308', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355138683924480, '2025-06-21 17:26:55.458605', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355143264104448, '2025-06-21 17:26:56.550443', 194232147738608, '$,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355147819118592, '2025-06-21 17:26:57.636059', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355152382521344, '2025-06-21 17:26:58.724533', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355156916563968, '2025-06-21 17:26:59.805355', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355162499182592, '2025-06-21 17:27:01.136602', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355167507181568, '2025-06-21 17:27:02.330451', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355172133498880, '2025-06-21 17:27:03.433033', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936355176965337088, '2025-06-21 17:27:04.585666', 194232147738608, '$BDGSV,1,1,00,0*7');
INSERT INTO "public"."device_temp_data" VALUES (1936355181528739840, '2025-06-21 17:27:05.673326', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355186150862848, '2025-06-21 17:27:06.775892', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355190684905472, '2025-06-21 17:27:07.856151', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355195877453824, '2025-06-21 17:27:09.094976', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355200377942016, '2025-06-21 17:27:10.167743', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,');
INSERT INTO "public"."device_temp_data" VALUES (1936355204974899200, '2025-06-21 17:27:11.263316', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355209525719040, '2025-06-21 17:27:12.348417', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355214076538880, '2025-06-21 17:27:13.433116', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355218702856192, '2025-06-21 17:27:14.536725', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355224335806464, '2025-06-21 17:27:15.879289', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355229431885824, '2025-06-21 17:27:17.094412', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355234091757568, '2025-06-21 17:27:18.205171', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355238671937536, '2025-06-21 17:27:19.297795', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355243231145984, '2025-06-21 17:27:20.384143', 194232147738608, '$GNGGA,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355247752605696, '2025-06-21 17:27:21.462247', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355252353757184, '2025-06-21 17:27:22.559113', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355256891994112, '2025-06-21 17:27:23.641089', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355261501534208, '2025-06-21 17:27:24.740936', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355266064936960, '2025-06-21 17:27:25.828234', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355270640922624, '2025-06-21 17:27:26.91944', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355275162382336, '2025-06-21 17:27:27.997504', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936355279767728128, '2025-06-21 17:27:29.095296', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355284410822656, '2025-06-21 17:27:30.202662', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355289133608960, '2025-06-21 17:27:31.328555', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355293722177536, '2025-06-21 17:27:32.422388', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355298310746112, '2025-06-21 17:27:33.516961', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355362550706176, '2025-06-21 17:27:48.832482', 194232147738608, 'RMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355362613620736, '2025-06-21 17:27:48.847816', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355362651369472, '2025-06-21 17:27:48.856807', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355367760031744, '2025-06-21 17:27:50.074388', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355372310851584, '2025-06-21 17:27:51.159015', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355376870060032, '2025-06-21 17:27:52.246936', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355381483794432, '2025-06-21 17:27:53.346648', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355386080751616, '2025-06-21 17:27:54.442303', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355390639960064, '2025-06-21 17:27:55.529733', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355395199168512, '2025-06-21 17:27:56.616459', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355399800320000, '2025-06-21 17:27:57.713363', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355404376305664, '2025-06-21 17:27:58.804225', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355408935514112, '2025-06-21 17:27:59.891673', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355413524082688, '2025-06-21 17:28:00.985213', 194232147738608, '$GNGSA,A,1,,,,,65');
INSERT INTO "public"."device_temp_data" VALUES (1936355418079096832, '2025-06-21 17:28:02.071166', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355422638305280, '2025-06-21 17:28:03.158141', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355427205902336, '2025-06-21 17:28:04.247884', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355431769305088, '2025-06-21 17:28:05.335358', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355436383039488, '2025-06-21 17:28:06.435601', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355440917082112, '2025-06-21 17:28:07.516644', 194232147738608, ',,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355445484679168, '2025-06-21 17:28:08.605989', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355450064859136, '2025-06-21 17:28:09.697813', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355454779256832, '2025-06-21 17:28:10.821382', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355459309105152, '2025-06-21 17:28:11.901619', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355463872507904, '2025-06-21 17:28:12.989489', 194232147738608, '$GNGLL,,,,,,V,N*,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355468398161920, '2025-06-21 17:28:14.068476', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355472982536192, '2025-06-21 17:28:15.161054', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355477583687680, '2025-06-21 17:28:16.25873', 194232147738608, '$GNGLL1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355482256142336, '2025-06-21 17:28:17.372931', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355486798573568, '2025-06-21 17:28:18.455466', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355491382947840, '2025-06-21 17:28:19.54832', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355495942156288, '2025-06-21 17:28:20.635295', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355500513947648, '2025-06-21 17:28:21.725168', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355505115099136, '2025-06-21 17:28:22.822438', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355509724639232, '2025-06-21 17:28:23.921507', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355514334179328, '2025-06-21 17:28:25.020368', 194232147738608, '$GNGSA,A,1,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355518893387776, '2025-06-21 17:28:26.107542', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355523511316480, '2025-06-21 17:28:27.208972', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355528057942016, '2025-06-21 17:28:28.292658', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355532629733376, '2025-06-21 17:28:29.382538', 194232147738608, '01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355537176358912, '2025-06-21 17:28:30.466755', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355541790093312, '2025-06-21 17:28:31.566223', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355546441576448, '2025-06-21 17:28:32.675556', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355550971424768, '2025-06-21 17:28:33.755117', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355555576770560, '2025-06-21 17:28:34.853316', 194232147738608, '$GPGSV,156');
INSERT INTO "public"."device_temp_data" VALUES (1936355560211476480, '2025-06-21 17:28:35.958082', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355564766490624, '2025-06-21 17:28:37.044393', 194232147738608, ',*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355569468305408, '2025-06-21 17:28:38.16533', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355574048485376, '2025-06-21 17:28:39.257162', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355578670608384, '2025-06-21 17:28:40.359588', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355583812825088, '2025-06-21 17:28:41.585698', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355588556582912, '2025-06-21 17:28:42.716576', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355593245814784, '2025-06-21 17:28:43.834457', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936355597817606144, '2025-06-21 17:28:44.92472', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355602376814592, '2025-06-21 17:28:46.011692', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355606948605952, '2025-06-21 17:28:47.10128', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355611528785920, '2025-06-21 17:28:48.1932', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355616129937408, '2025-06-21 17:28:49.290064', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355620701728768, '2025-06-21 17:28:50.380173', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355625311268864, '2025-06-21 17:28:51.479273', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355629904031744, '2025-06-21 17:28:52.574665', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355634480017408, '2025-06-21 17:28:53.665598', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355639030837248, '2025-06-21 17:28:54.750914', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355643577462784, '2025-06-21 17:28:55.834519', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355648178614272, '2025-06-21 17:28:56.931815', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355652821708800, '2025-06-21 17:28:58.038901', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355668604874752, '2025-06-21 17:29:01.80101', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355673201831936, '2025-06-21 17:29:02.89785', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355677719097344, '2025-06-21 17:29:03.97467', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355682261528576, '2025-06-21 17:29:05.057779', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355686845902848, '2025-06-21 17:29:06.150314', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355691430277120, '2025-06-21 17:29:07.243382', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355695960125440, '2025-06-21 17:29:08.323686', 194232147738608, '$GPGSV01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355700502556672, '2025-06-21 17:29:09.4066', 194232147738608, '$GNGGA,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355705103708160, '2025-06-21 17:29:10.503079', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355709721636864, '2025-06-21 17:29:11.604974', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355714322788352, '2025-06-21 17:29:12.701994', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355719012020224, '2025-06-21 17:29:13.819687', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355723575422976, '2025-06-21 17:29:14.907724', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355728143020032, '2025-06-21 17:29:15.99605', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355732698034176, '2025-06-21 17:29:17.082245', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355737320157184, '2025-06-21 17:29:18.184222', 194232147738608, '$GPGSV,1,1,01,03,,,22,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936355741900337152, '2025-06-21 17:29:19.276698', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355746497294336, '2025-06-21 17:29:20.372715', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355751069085696, '2025-06-21 17:29:21.462139', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355755586351104, '2025-06-21 17:29:22.539701', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355760145559552, '2025-06-21 17:29:23.626834', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355764717350912, '2025-06-21 17:29:24.716972', 194232147738608, 'GSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355769247199232, '2025-06-21 17:29:25.796576', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355773789630464, '2025-06-21 17:29:26.879236', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355778348838912, '2025-06-21 17:29:27.966966', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355782937407488, '2025-06-21 17:29:29.060645', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355787551141888, '2025-06-21 17:29:30.160961', 194232147738608, '$GNGGA,,,,,,0,00,2 OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355796677947392, '2025-06-21 17:29:32.336059', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355801266515968, '2025-06-21 17:29:33.430476', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355805846695936, '2025-06-21 17:29:34.522034', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355810447847424, '2025-06-21 17:29:35.619885', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355815002861568, '2025-06-21 17:29:36.705948', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355819994083328, '2025-06-21 17:29:37.895425', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355824565874688, '2025-06-21 17:29:38.985256', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355829175414784, '2025-06-21 17:29:40.084297', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936355834548318208, '2025-06-21 17:29:41.365749', 194232147738608, '$GPGSV,1,1,00,0$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355839287881728, '2025-06-21 17:29:42.495638', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355844413321216, '2025-06-21 17:29:43.717418', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355848938975232, '2025-06-21 17:29:44.796351', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355853510766592, '2025-06-21 17:29:45.886569', 194232147738608, '$GPTXT,01,01,01,A,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355858082557952, '2025-06-21 17:29:46.976037', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355862734041088, '2025-06-21 17:29:48.085774', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355867356164096, '2025-06-21 17:29:49.187075', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355871995064320, '2025-06-21 17:29:50.293481', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355876566855680, '2025-06-21 17:29:51.383798', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936355881142841344, '2025-06-21 17:29:52.474785', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355885764964352, '2025-06-21 17:29:53.576389', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355890336755712, '2025-06-21 17:29:54.666965', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355894912741376, '2025-06-21 17:29:55.757118', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355899568418816, '2025-06-21 17:29:56.867506', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355904127627264, '2025-06-21 17:29:57.95405', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355908720390144, '2025-06-21 17:29:59.049389', 194232147738608, '$GNGLN,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355913313153024, '2025-06-21 17:30:00.144531', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355917897527296, '2025-06-21 17:30:01.237451', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355922494484480, '2025-06-21 17:30:02.333117', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355927091441664, '2025-06-21 17:30:03.429284', 194232147738608, '$GNGGA,,,,,,0,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936355931654844416, '2025-06-21 17:30:04.517816', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936355936209858560, '2025-06-21 17:30:05.603485', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936355940773261312, '2025-06-21 17:30:06.691452', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936355945357635584, '2025-06-21 17:30:07.784056', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355950004924416, '2025-06-21 17:30:08.892773', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355954572521472, '2025-06-21 17:30:09.981881', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355959177867264, '2025-06-21 17:30:11.079357', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936355963724492800, '2025-06-21 17:30:12.163429', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936355968296284160, '2025-06-21 17:30:13.253232', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355972930990080, '2025-06-21 17:30:14.358939', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355978429722624, '2025-06-21 17:30:15.669892', 194232147738608, 'DA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936355988764487680, '2025-06-21 17:30:18.133949', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936355993399193600, '2025-06-21 17:30:19.238693', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936355998717571072, '2025-06-21 17:30:20.506166', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356003373248512, '2025-06-21 17:30:21.616628', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356007978594304, '2025-06-21 17:30:22.714854', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356012525219840, '2025-06-21 17:30:23.798637', 194232147738608, '$GPGSV,1,1,01,05,,,25,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936356017138954240, '2025-06-21 17:30:24.898814', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356021710745600, '2025-06-21 17:30:25.988684', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356026320285696, '2025-06-21 17:30:27.087811', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356030942408704, '2025-06-21 17:30:28.189552', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356035522588672, '2025-06-21 17:30:29.281953', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356040236986368, '2025-06-21 17:30:30.405042', 194232147738608, ',,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356044783611904, '2025-06-21 17:30:31.489215', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356049355403264, '2025-06-21 17:30:32.579944', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356053960749056, '2025-06-21 17:30:33.677566', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356058557706240, '2025-06-21 17:30:34.77331', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356063083360256, '2025-06-21 17:30:35.852025', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356067625791488, '2025-06-21 17:30:36.935558', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356072201777152, '2025-06-21 17:30:38.02607', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356076756791296, '2025-06-21 17:30:39.112545', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356081307611136, '2025-06-21 17:30:40.197279', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356086022008832, '2025-06-21 17:30:41.321379', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356090736406528, '2025-06-21 17:30:42.445572', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356095383695360, '2025-06-21 17:30:43.55335', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,21,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356099980652544, '2025-06-21 17:30:44.649032', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356104556638208, '2025-06-21 17:30:45.740568', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356109187149824, '2025-06-21 17:30:46.844759', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356113775718400, '2025-06-21 17:30:47.938584', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356118313955328, '2025-06-21 17:30:49.020074', 194232147738608, ',,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356122885746688, '2025-06-21 17:30:50.110488', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356127486898176, '2025-06-21 17:30:51.207551', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356132067078144, '2025-06-21 17:30:52.299985', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356136693395456, '2025-06-21 17:30:53.402439', 194232147738608, '$GPGSV,1,1,00,02E');
INSERT INTO "public"."device_temp_data" VALUES (1936356141269381120, '2025-06-21 17:30:54.493851', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356145832783872, '2025-06-21 17:30:55.58127', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356150400380928, '2025-06-21 17:30:56.670739', 194232147738608, '$GNGGA,,,,,,0,00,2SA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356154947006464, '2025-06-21 17:30:57.754904', 194232147738608, '$GPGSV,1,1,01,05,,,25,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936356159510409216, '2025-06-21 17:30:58.842536', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356164115755008, '2025-06-21 17:30:59.94086', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356168763043840, '2025-06-21 17:31:01.048316', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356173322252288, '2025-06-21 17:31:02.135608', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356177864683520, '2025-06-21 17:31:03.218055', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356182432280576, '2025-06-21 17:31:04.307626', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356186991489024, '2025-06-21 17:31:05.394024', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356191525531648, '2025-06-21 17:31:06.475886', 194232147738608, '$0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356196130877440, '2025-06-21 17:31:07.573064', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356200740417536, '2025-06-21 17:31:08.672543', 194232147738608, '$G,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356205333180416, '2025-06-21 17:31:09.767835', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356209938526208, '2025-06-21 17:31:10.865587', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356214522900480, '2025-06-21 17:31:11.958951', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356219186966528, '2025-06-21 17:31:13.070505', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356223737786368, '2025-06-21 17:31:14.155047', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356228292800512, '2025-06-21 17:31:15.241529', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356232835231744, '2025-06-21 17:31:16.324571', 194232147738608, '$GPGSV,1,1,01,05,,,NGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356237407023104, '2025-06-21 17:31:17.414852', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356241974620160, '2025-06-21 17:31:18.5039', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356246613520384, '2025-06-21 17:31:19.609471', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2500,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356251231449088, '2025-06-21 17:31:20.710619', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356256293974016, '2025-06-21 17:31:21.917761', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356260861571072, '2025-06-21 17:31:23.006549', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356265416585216, '2025-06-21 17:31:24.092137', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356270030319616, '2025-06-21 17:31:25.192635', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356274560167936, '2025-06-21 17:31:26.272798', 194232147738608, '$GNGLL,,,,,,V,TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356279131959296, '2025-06-21 17:31:27.362924', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356283724722176, '2025-06-21 17:31:28.457061', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356288317485056, '2025-06-21 17:31:29.552328', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356292906053632, '2025-06-21 17:31:30.646908', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356297461067776, '2025-06-21 17:31:31.732312', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356301995110400, '2025-06-21 17:31:32.813251', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356306562707456, '2025-06-21 17:31:33.902738', 194232147738608, '$GPG');
INSERT INTO "public"."device_temp_data" VALUES (1936356311138693120, '2025-06-21 17:31:34.993343', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356315731456000, '2025-06-21 17:31:36.088086', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356320324218880, '2025-06-21 17:31:37.183109', 194232147738608, ',,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356324879233024, '2025-06-21 17:31:38.26953', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356329497161728, '2025-06-21 17:31:39.370982', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356334228336640, '2025-06-21 17:31:40.498028', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356338921762816, '2025-06-21 17:31:41.617993', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356344407912448, '2025-06-21 17:31:42.925833', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356348975509504, '2025-06-21 17:31:44.014431', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356353509552128, '2025-06-21 17:31:45.095955', 194232147738608, '$GPGSV,1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356358102315008, '2025-06-21 17:31:46.190543', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356362669912064, '2025-06-21 17:31:47.27815', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356367237509120, '2025-06-21 17:31:48.368731', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356371838660608, '2025-06-21 17:31:49.465785', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356376351731712, '2025-06-21 17:31:50.541375', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356380864802816, '2025-06-21 17:31:51.61769', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936356385373679616, '2025-06-21 17:31:52.69288', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356389974831104, '2025-06-21 17:31:53.78966', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356394529845248, '2025-06-21 17:31:54.875988', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356399160356864, '2025-06-21 17:31:55.979643', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356403824422912, '2025-06-21 17:31:57.091573', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356408362659840, '2025-06-21 17:31:58.17329', 194232147738608, 'PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356412921868288, '2025-06-21 17:31:59.260656', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356417497853952, '2025-06-21 17:32:00.351022', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356422073839616, '2025-06-21 17:32:01.442137', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356426624659456, '2025-06-21 17:32:02.527503', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356431230005248, '2025-06-21 17:32:03.625608', 194232147738608, '$GPGSV,1,1,01,5');
INSERT INTO "public"."device_temp_data" VALUES (1936356436275752960, '2025-06-21 17:32:04.828132', 194232147738608, '$GNGGA,,,,,,0,00,2A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356440822378496, '2025-06-21 17:32:05.912827', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356445381586944, '2025-06-21 17:32:06.999807', 194232147738608, '$GPGSV,1,1,01,197,,,25,0*5C');
INSERT INTO "public"."device_temp_data" VALUES (1936356449999515648, '2025-06-21 17:32:08.100278', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356454751662080, '2025-06-21 17:32:09.233637', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356459273121792, '2025-06-21 17:32:10.311429', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356463815553024, '2025-06-21 17:32:11.394651', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356468383150080, '2025-06-21 17:32:12.483774', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356472938164224, '2025-06-21 17:32:13.569321', 194232147738608, '$GNGGA,,,,,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356477505761280, '2025-06-21 17:32:14.658576', 194232147738608, ',,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356482127884288, '2025-06-21 17:32:15.76027', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356486691287040, '2025-06-21 17:32:16.848232', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356491288244224, '2025-06-21 17:32:17.944809', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936356495881007104, '2025-06-21 17:32:19.039664', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356500456992768, '2025-06-21 17:32:20.130272', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356505028784128, '2025-06-21 17:32:21.220608', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356509571215360, '2025-06-21 17:32:22.303243', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356514168172544, '2025-06-21 17:32:23.3992', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356518744158208, '2025-06-21 17:32:24.490188', 194232147738608, '$GNGGA,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356523349504000, '2025-06-21 17:32:25.588376', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356527904518144, '2025-06-21 17:32:26.674844', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356532472115200, '2025-06-21 17:32:27.763178', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356537115209728, '2025-06-21 17:32:28.870209', 194232147738608, '$GNGL,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356541670223872, '2025-06-21 17:32:29.956161', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356546229432320, '2025-06-21 17:32:31.043638', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356550797029376, '2025-06-21 17:32:32.132902', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356555461095424, '2025-06-21 17:32:33.244543', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356560053858304, '2025-06-21 17:32:34.33907', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356565141549056, '2025-06-21 17:32:35.552973', 194232147738608, '$GNGSA,,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936356569717534720, '2025-06-21 17:32:36.643146', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356574301908992, '2025-06-21 17:32:37.736042', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356578932420608, '2025-06-21 17:32:38.840272', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356584867360768, '2025-06-21 17:32:40.255048', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356590147989504, '2025-06-21 17:32:41.514165', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356594849804288, '2025-06-21 17:32:42.635994', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356599522258944, '2025-06-21 17:32:43.749277', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356604635115520, '2025-06-21 17:32:44.968712', 194232147738608, '$GNGSA,A,1,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356609253044224, '2025-06-21 17:32:46.069319', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356613837418496, '2025-06-21 17:32:47.162988', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356618396626944, '2025-06-21 17:32:48.249961', 194232147738608, 'TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356622960029696, '2025-06-21 17:32:49.33733', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356627582152704, '2025-06-21 17:32:50.439999', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356632191692800, '2025-06-21 17:32:51.538782', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356637744951296, '2025-06-21 17:32:52.862136', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356645080788992, '2025-06-21 17:32:54.611816', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936356649778409472, '2025-06-21 17:32:55.731366', 194232147738608, '$BDGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936356654366978048, '2025-06-21 17:32:56.82584', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356659056209920, '2025-06-21 17:32:57.943345', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356663640584192, '2025-06-21 17:32:59.036396', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356668262707200, '2025-06-21 17:33:00.138687', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356672796749824, '2025-06-21 17:33:01.21921', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356677414678528, '2025-06-21 17:33:02.320536', 194232147738608, '01,46,,,27,0*72');
INSERT INTO "public"."device_temp_data" VALUES (1936356681982275584, '2025-06-21 17:33:03.409294', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356688437309440, '2025-06-21 17:33:04.9487', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356692975546368, '2025-06-21 17:33:06.03093', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356697555726336, '2025-06-21 17:33:07.12232', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356702240763904, '2025-06-21 17:33:08.239365', 194232147738608, '$GNGGA,,,,,,0,00,');
INSERT INTO "public"."device_temp_data" VALUES (1936356706766417920, '2025-06-21 17:33:09.318574', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356711266906112, '2025-06-21 17:33:10.391694', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356715805143040, '2025-06-21 17:33:11.473959', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356720330797056, '2025-06-21 17:33:12.552197', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356724869033984, '2025-06-21 17:33:13.634791', 194232147738608, '7');
INSERT INTO "public"."device_temp_data" VALUES (1936356729612791808, '2025-06-21 17:33:14.765006', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356734213943296, '2025-06-21 17:33:15.862368', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356738865426432, '2025-06-21 17:33:16.971077', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356755835580416, '2025-06-21 17:33:21.017232', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356766547832832, '2025-06-21 17:33:23.571958', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356771274813440, '2025-06-21 17:33:24.698031', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356775892742144, '2025-06-21 17:33:25.799702', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356780506476544, '2025-06-21 17:33:26.899731', 194232147738608, '$GNGLTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356785090850816, '2025-06-21 17:33:27.992935', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356790132404224, '2025-06-21 17:33:29.194085', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356795983458304, '2025-06-21 17:33:30.589091', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356800588804096, '2025-06-21 17:33:31.687845', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356805152206848, '2025-06-21 17:33:32.775427', 194232147738608, '$GPGSV,1,1,03,09,,,23,12,,,27,32,,,27,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936356809723998208, '2025-06-21 17:33:33.865612', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356820188786688, '2025-06-21 17:33:36.360053', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356824764772352, '2025-06-21 17:33:37.4518', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356832268382208, '2025-06-21 17:33:39.240845', 194232147738608, '$GNZD*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356836936642560, '2025-06-21 17:33:40.353495', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356841751703552, '2025-06-21 17:33:41.501197', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356846986194944, '2025-06-21 17:33:42.749587', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356851620900864, '2025-06-21 17:33:43.85458', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356856226246656, '2025-06-21 17:33:44.952892', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936356860839981056, '2025-06-21 17:33:46.052781', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936356865759899648, '2025-06-21 17:33:47.225516', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936356870423965696, '2025-06-21 17:33:48.337896', 194232147738608, '$BDGSV,1,1,00,0*7,02,09,,,23,32,,,26,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936356875012534272, '2025-06-21 17:33:49.431748', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936356879605297152, '2025-06-21 17:33:50.526701', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936356884168699904, '2025-06-21 17:33:51.614599', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356894469910528, '2025-06-21 17:33:54.070118', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356899050090496, '2025-06-21 17:33:55.162461', 194232147738608, '$GPTXT,01,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356903647047680, '2025-06-21 17:33:56.25896', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936356908277559296, '2025-06-21 17:33:57.362192', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356912996151296, '2025-06-21 17:33:58.487998', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936356917735714816, '2025-06-21 17:33:59.617917', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936356922462695424, '2025-06-21 17:34:00.744406', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25357.000,V,,,,,,,,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936356927298727936, '2025-06-21 17:34:01.897935', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936356942507274240, '2025-06-21 17:34:05.523124', 194232147738608, '$GNZDA,093357.000,,,,,*43');
INSERT INTO "public"."device_temp_data" VALUES (1936356947070676992, '2025-06-21 17:34:06.611438', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936356951780880384, '2025-06-21 17:34:07.734566', 194232147738608, '$GNGGA,093358.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936356973951971328, '2025-06-21 17:34:13.020868', 194232147738608, '$GNGLL,,,,,093358.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936356990901153792, '2025-06-21 17:34:17.061761', 194232147738608, '1,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357007728701440, '2025-06-21 17:34:21.07337', 194232147738608, '$GNGGA,093401.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936357024447197184, '2025-06-21 17:34:25.059007', 194232147738608, '$GNGLL,,,,,0934,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357029077708800, '2025-06-21 17:34:26.163295', 194232147738608, '$GNZDA,093422.000,,,,,*46');
INSERT INTO "public"."device_temp_data" VALUES (1936357033695637504, '2025-06-21 17:34:27.264015', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357040192614400, '2025-06-21 17:34:28.81382', 194232147738608, '$GNGGA,093423.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936357045808787456, '2025-06-21 17:34:30.152588', 194232147738608, '$GNGLL,,,,,093423.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936357050468659200, '2025-06-21 17:34:31.263207', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357056835612672, '2025-06-21 17:34:32.781534', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936357061558398976, '2025-06-21 17:34:33.907376', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936357066281185280, '2025-06-21 17:34:35.033002', 194232147738608, '$*43');
INSERT INTO "public"."device_temp_data" VALUES (1936357070852976640, '2025-06-21 17:34:36.123249', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357075454128128, '2025-06-21 17:34:37.22057', 194232147738608, '$GNGGA,093428.000,,,,,0,00,25.34.000,V,,,,,,,,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936357082223734784, '2025-06-21 17:34:38.834079', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357087449837568, '2025-06-21 17:34:40.08', 194232147738608, '$GNZDA,093434.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936357095125413888, '2025-06-21 17:34:41.910586', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357102503194624, '2025-06-21 17:34:43.669002', 194232147738608, '$GNGGA,093435.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936357111386730496, '2025-06-21 17:34:45.787066', 194232147738608, '$GNGLL,,,,,093435.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936357116025630720, '2025-06-21 17:34:46.893024', 194232147738608, '$GNGSA,A,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936357133528461312, '2025-06-21 17:34:51.066979', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936357150494420992, '2025-06-21 17:34:55.111036', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357162553044992, '2025-06-21 17:34:57.986433', 194232147738608, '$GNRMC,093447.000,V,,,,,,,,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936357167808507904, '2025-06-21 17:34:59.239509', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357174536171520, '2025-06-21 17:35:00.843429', 194232147738608, '$GNZDA,093447.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936357183033831424, '2025-06-21 17:35:02.869776', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357192852697088, '2025-06-21 17:35:05.210725', 194232147738608, '$GNGGA,093448.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936357232686002176, '2025-06-21 17:35:14.707114', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357238117625856, '2025-06-21 17:35:16.002785', 194232147738608, '$GNRMC,093458.000,V,,,,,,,,0,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357244216143872, '2025-06-21 17:35:17.456181', 194232147738608, '$GNRMC,093508.000,V,,,,,,,,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357249823928320, '2025-06-21 17:35:18.793891', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357259240140800, '2025-06-21 17:35:21.038823', 194232147738608, '$GNZDA,093508.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936357264613044224, '2025-06-21 17:35:22.319663', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357273442054144, '2025-06-21 17:35:24.424151', 194232147738608, '$GNGGA,093509.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936357280475901952, '2025-06-21 17:35:26.101145', 194232147738608, '$GNGLL,,,,,09,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357286213709824, '2025-06-21 17:35:27.469462', 194232147738608, '$GNGGA,093523.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357303544573952, '2025-06-21 17:35:31.60196', 194232147738608, '$GNGLL,,,,,093523.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936357311287259136, '2025-06-21 17:35:33.447254', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357316320423936, '2025-06-21 17:35:34.647945', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936357321462640640, '2025-06-21 17:35:35.87312', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*,,,,,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936357326671966208, '2025-06-21 17:35:37.115501', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357357516877824, '2025-06-21 17:35:44.469717', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357395353694208, '2025-06-21 17:35:53.490586', 194232147738608, ',,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357429600186368, '2025-06-21 17:36:01.655202', 194232147738608, '$GPGSV,1,1,02,17,,,22,32,,,25,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936357439758790656, '2025-06-21 17:36:04.077903', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357457999818752, '2025-06-21 17:36:08.426124', 194232147738608, '$GNRMC,093536.000,V,,,,,,,,,,N,V*238.000,V,,,,,,,,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936357463574048768, '2025-06-21 17:36:09.755303', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357477545275392, '2025-06-21 17:36:13.086866', 194232147738608, '$GNZDA,093538.000,,,,,*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936357486441394176, '2025-06-21 17:36:15.207713', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357503189250048, '2025-06-21 17:36:19.200819', 194232147738608, '41');
INSERT INTO "public"."device_temp_data" VALUES (1936357508549570560, '2025-06-21 17:36:20.478951', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357526178230272, '2025-06-21 17:36:24.681946', 194232147738608, '$GNGGA,093606.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936357530884239360, '2025-06-21 17:36:25.803149', 194232147738608, '$GNGLL,,,,,093606.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936357573750026240, '2025-06-21 17:36:36.023599', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357580439941120, '2025-06-21 17:36:37.618623', 194232147738608, '$GNGGA,093612.00,01,01,02,TB=2020-03-26,13:25:12*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936357586894974976, '2025-06-21 17:36:39.157427', 194232147738608, '$GPTXT,01,01,02,MO=GB*77');
INSERT INTO "public"."device_temp_data" VALUES (1936357606738227200, '2025-06-21 17:36:43.888363', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357611402293248, '2025-06-21 17:36:45.00042', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936357616208965632, '2025-06-21 17:36:46.146376', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357622919852032, '2025-06-21 17:36:47.746823', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357627407757312, '2025-06-21 17:36:48.816349', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357631920828416, '2025-06-21 17:36:49.892533', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357636412928000, '2025-06-21 17:36:50.963931', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357640959553536, '2025-06-21 17:36:52.047205', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357645451653120, '2025-06-21 17:36:53.118098', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357649973112832, '2025-06-21 17:36:54.196905', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357654523932672, '2025-06-21 17:36:55.281709', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357658986672128, '2025-06-21 17:36:56.345625', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357663445217280, '2025-06-21 17:36:57.408569', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357667970871296, '2025-06-21 17:36:58.487452', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936357672509108224, '2025-06-21 17:36:59.569552', 194232147738608, '$');
INSERT INTO "public"."device_temp_data" VALUES (1936357677005402112, '2025-06-21 17:37:00.641961', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357681531056128, '2025-06-21 17:37:01.720847', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357686052515840, '2025-06-21 17:37:02.798998', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357690540421120, '2025-06-21 17:37:03.868819', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357695057686528, '2025-06-21 17:37:04.945866', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357699566563328, '2025-06-21 17:37:06.020608', 194232147738608, '$1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357704075440128, '2025-06-21 17:37:07.095031', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357708613677056, '2025-06-21 17:37:08.177154', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357713143525376, '2025-06-21 17:37:09.257929', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357717610459136, '2025-06-21 17:37:10.32259', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357722614263808, '2025-06-21 17:37:11.515145', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357727135723520, '2025-06-21 17:37:12.593035', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357731690737664, '2025-06-21 17:37:13.679513', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*09,0*5E');
INSERT INTO "public"."device_temp_data" VALUES (1936357736233168896, '2025-06-21 17:37:14.762675', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357740788183040, '2025-06-21 17:37:15.84847', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357745309642752, '2025-06-21 17:37:16.926239', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357749780770816, '2025-06-21 17:37:17.992645', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357754331590656, '2025-06-21 17:37:19.077113', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357758832078848, '2025-06-21 17:37:20.150576', 194232147738608, '$56');
INSERT INTO "public"."device_temp_data" VALUES (1936357763361927168, '2025-06-21 17:37:21.230121', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357767841443840, '2025-06-21 17:37:22.29813', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357772350320640, '2025-06-21 17:37:23.373507', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357776855003136, '2025-06-21 17:37:24.44753', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*0TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357781384851456, '2025-06-21 17:37:25.527744', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357785956642816, '2025-06-21 17:37:26.617479', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357802847105024, '2025-06-21 17:37:30.644227', 194232147738608, ',,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357808031264768, '2025-06-21 17:37:31.880605', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357812531752960, '2025-06-21 17:37:32.953993', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357817107738624, '2025-06-21 17:37:34.04485', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357821629198336, '2025-06-21 17:37:35.122971', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357826163240960, '2025-06-21 17:37:36.203614', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357830634369024, '2025-06-21 17:37:37.269179', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357835118080000, '2025-06-21 17:37:38.338198', 194232147738608, '$GNGSA,A,127,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936357839635345408, '2025-06-21 17:37:39.415084', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357844186165248, '2025-06-21 17:37:40.500503', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357848741179392, '2025-06-21 17:37:41.586231', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357853363302400, '2025-06-21 17:37:42.688159', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357857888956416, '2025-06-21 17:37:43.767423', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357862397833216, '2025-06-21 17:37:44.842203', 194232147738608, 'G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357866906710016, '2025-06-21 17:37:45.917081', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357871361060864, '2025-06-21 17:37:46.979033', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357875886714880, '2025-06-21 17:37:48.058016', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357880387203072, '2025-06-21 17:37:49.131454', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357884896079872, '2025-06-21 17:37:50.20635', 194232147738608, '$GNGSA,A,1,,');
INSERT INTO "public"."device_temp_data" VALUES (1936357889425928192, '2025-06-21 17:37:51.286627', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357894035468288, '2025-06-21 17:37:52.384552', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357898556928000, '2025-06-21 17:37:53.463584', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357903082582016, '2025-06-21 17:37:54.542497', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357907578875904, '2025-06-21 17:37:55.614915', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357912070975488, '2025-06-21 17:37:56.685267', 194232147738608, '27,32,,,30,195,,,30,197,,,32,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936357916579852288, '2025-06-21 17:37:57.760647', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936357921063563264, '2025-06-21 17:37:58.82906', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357925534691328, '2025-06-21 17:37:59.895846', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357930060345344, '2025-06-21 17:38:00.974306', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357934577610752, '2025-06-21 17:38:02.05165', 194232147738608, '$GPTXT,01,01,01,A');
INSERT INTO "public"."device_temp_data" VALUES (1936357939082293248, '2025-06-21 17:38:03.125009', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936357943599558656, '2025-06-21 17:38:04.202373', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936357948150378496, '2025-06-21 17:38:05.287032', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357952667643904, '2025-06-21 17:38:06.364354', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357957176520704, '2025-06-21 17:38:07.439022', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936357961693786112, '2025-06-21 17:38:08.516231', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936357966236217344, '2025-06-21 17:38:09.599956', 194232147738608, '$GPGSV,3,1,11,05,,,33,06,,,31,10,,,33,12,,,34,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936357970749288448, '2025-06-21 17:38:10.67553', 194232147738608, '$GPGSV,3,2,11,14,,3,12,,,34,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936357975270748160, '2025-06-21 17:38:11.753016', 194232147738608, '$GPGSV,3,2,09,14,,,30,25,,,28,30,,,30,32,,,31,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936357979788013568, '2025-06-21 17:38:12.830935', 194232147738608, ',,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936357984305278976, '2025-06-21 17:38:13.907573', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936357988822544384, '2025-06-21 17:38:14.984194', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936357993331421184, '2025-06-21 17:38:16.059572', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936357997869658112, '2025-06-21 17:38:17.141119', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358002374340608, '2025-06-21 17:38:18.215206', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358006899994624, '2025-06-21 17:38:19.294801', 194232147738608, '$GPGSV,3,V,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358011467591680, '2025-06-21 17:38:20.383358', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358015993245696, '2025-06-21 17:38:21.46264', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358020523094016, '2025-06-21 17:38:22.542678', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358025015193600, '2025-06-21 17:38:23.613915', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358029494710272, '2025-06-21 17:38:24.681225', 194232147738608, 'SV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358033986809856, '2025-06-21 17:38:25.752463', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358038491492352, '2025-06-21 17:38:26.826252', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358043054895104, '2025-06-21 17:38:27.914366', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358047614103552, '2025-06-21 17:38:29.001297', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358052127174656, '2025-06-21 17:38:30.07705', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358056694771712, '2025-06-21 17:38:31.166846', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358071269978112, '2025-06-21 17:38:34.641601', 194232147738608, '$5.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358075804020736, '2025-06-21 17:38:35.722492', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358080367423488, '2025-06-21 17:38:36.810938', 194232147738608, '$GPGSV,3,1,12,01,,,32,10,,,32,12,,,32,14,,,29,0*68');
INSERT INTO "public"."device_temp_data" VALUES (1936358084838551552, '2025-06-21 17:38:37.876753', 194232147738608, '$GPGSV,3,2,12,16,,,30,18,,,30,19,,,31,24,,,31,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936358089351622656, '2025-06-21 17:38:38.952757', 194232147738608, '$GPGSV,3,3,12,28,,,26,30,,,28,32,,,29,194,,,30,0*54');
INSERT INTO "public"."device_temp_data" VALUES (1936358093873082368, '2025-06-21 17:38:40.030628', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358098503593984, '2025-06-21 17:38:41.134558', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358103016665088, '2025-06-21 17:38:42.21038', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358107517153280, '2025-06-21 17:38:43.283869', 194232147738608, '$GPGSV,1,1,04,10,,,29,28,,,23,29,,,22,32,,,28,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936358112969748480, '2025-06-21 17:38:44.583942', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358117449265152, '2025-06-21 17:38:45.651277', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358121987502080, '2025-06-21 17:38:46.733247', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358126508961792, '2025-06-21 17:38:47.811781', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358131437268992, '2025-06-21 17:38:48.986941', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358135895814144, '2025-06-21 17:38:50.049737', 194232147738608, '$GNG');
INSERT INTO "public"."device_temp_data" VALUES (1936358140417273856, '2025-06-21 17:38:51.127538', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358144913567744, '2025-06-21 17:38:52.199881', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358149472776192, '2025-06-21 17:38:53.286342', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358153981652992, '2025-06-21 17:38:54.361819', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358162001162240, '2025-06-21 17:38:56.273753', 194232147738608, '$GNGGA,,,,,,0,00,,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358166568759296, '2025-06-21 17:38:57.362769', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358171165716480, '2025-06-21 17:38:58.458356', 194232147738608, '$GPGSV,2,1,05,10,,,29,14,,,28,25,,,26,32,,,28,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936358175775256576, '2025-06-21 17:38:59.557822', 194232147738608, '$GPGSV,2,GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358180862947328, '2025-06-21 17:39:00.77085', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358185468293120, '2025-06-21 17:39:01.868342', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358190019112960, '2025-06-21 17:39:02.953662', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358194569932800, '2025-06-21 17:39:04.038637', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358199091392512, '2025-06-21 17:39:05.116796', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358204699176960, '2025-06-21 17:39:06.453444', 194232147738608, '$GNGSA,A,1,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358209698787328, '2025-06-21 17:39:07.645133', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358214291550208, '2025-06-21 17:39:08.74093', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358218842370048, '2025-06-21 17:39:09.825001', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358223430938624, '2025-06-21 17:39:10.919384', 194232147738608, '$GNGGA,,,,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358228078227456, '2025-06-21 17:39:12.027296', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358232603881472, '2025-06-21 17:39:13.106378', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358237150507008, '2025-06-21 17:39:14.190224', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358241655189504, '2025-06-21 17:39:15.264512', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358246218592256, '2025-06-21 17:39:16.352204', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358250781995008, '2025-06-21 17:39:17.440222', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358255290871808, '2025-06-21 17:39:18.515396', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358259820720128, '2025-06-21 17:39:19.59577', 194232147738608, '$GPGSV,1,1,02,12,,,N*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358264350568448, '2025-06-21 17:39:20.675138', 194232147738608, '$GN,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358268867833856, '2025-06-21 17:39:21.752388', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358273343156224, '2025-06-21 17:39:22.819802', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358277902364672, '2025-06-21 17:39:23.906459', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358282419630080, '2025-06-21 17:39:24.983393', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358286983032832, '2025-06-21 17:39:26.071149', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358291626127360, '2025-06-21 17:39:27.178419', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358296176947200, '2025-06-21 17:39:28.263474', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358300765515776, '2025-06-21 17:39:29.357692', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358305295364096, '2025-06-21 17:39:30.437206', 194232147738608, '$GPGSV1,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358309837795328, '2025-06-21 17:39:31.520029', 194232147738608, '74');
INSERT INTO "public"."device_temp_data" VALUES (1936358314359255040, '2025-06-21 17:39:32.59811', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358318910074880, '2025-06-21 17:39:33.683748', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358323423145984, '2025-06-21 17:39:34.759051', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358327940411392, '2025-06-21 17:39:35.83657', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358332445093888, '2025-06-21 17:39:36.910588', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358336974942208, '2025-06-21 17:39:37.990619', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358341571899392, '2025-06-21 17:39:39.086918', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358346194022400, '2025-06-21 17:39:40.188822', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358351906664448, '2025-06-21 17:39:41.550845', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358356499427328, '2025-06-21 17:39:42.645734', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358361016692736, '2025-06-21 17:39:43.722095', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358365630427136, '2025-06-21 17:39:44.822359', 194232147738608, '$GNGS,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358370185441280, '2025-06-21 17:39:45.908627', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936358375013085184, '2025-06-21 17:39:47.059259', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358379597459456, '2025-06-21 17:39:48.152471', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358384118919168, '2025-06-21 17:39:49.230555', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358388694904832, '2025-06-21 17:39:50.321157', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358393254113280, '2025-06-21 17:39:51.408154', 194232147738608, '$25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936358397830098944, '2025-06-21 17:39:52.49997', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358402368335872, '2025-06-21 17:39:53.581308', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358406982070272, '2025-06-21 17:39:54.681024', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358411469975552, '2025-06-21 17:39:55.751368', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358416012406784, '2025-06-21 17:39:56.834184', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358420634529792, '2025-06-21 17:39:57.936018', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358425160183808, '2025-06-21 17:39:59.015008', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358429694226432, '2025-06-21 17:40:00.096849', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358434303766528, '2025-06-21 17:40:01.195517', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358438871363584, '2025-06-21 17:40:02.284388', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358443401211904, '2025-06-21 17:40:03.364445', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358447918477312, '2025-06-21 17:40:04.441724', 194232147738608, ',25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358452402188288, '2025-06-21 17:40:05.510974', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358456944619520, '2025-06-21 17:40:06.593567', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936358462166528000, '2025-06-21 17:40:07.838846', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358467103223808, '2025-06-21 17:40:09.014336', 194232147738608, '$GNRMC,,V,,,,,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358472081862656, '2025-06-21 17:40:10.202455', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358477849030656, '2025-06-21 17:40:11.5775', 194232147738608, '$GN37');
INSERT INTO "public"."device_temp_data" VALUES (1936358483024801792, '2025-06-21 17:40:12.811849', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358488175407104, '2025-06-21 17:40:14.03924', 194232147738608, '$GNZDA,,,,,,*56,,,,,,N,V*37');
INSERT INTO "public"."device_temp_data" VALUES (1936358493334401024, '2025-06-21 17:40:15.269445', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358498489200640, '2025-06-21 17:40:16.498115', 194232147738608, '$GNZDA,,,,,,*56');
INSERT INTO "public"."device_temp_data" VALUES (1936358503815966720, '2025-06-21 17:40:17.768554', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358508329037824, '2025-06-21 17:40:18.843188', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358512896634880, '2025-06-21 17:40:19.933061', 194232147738608, '$GNGLL,,,,,,V,N*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936358517418094592, '2025-06-21 17:40:21.01194', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358521968914432, '2025-06-21 17:40:22.096492', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358526565871616, '2025-06-21 17:40:23.192565', 194232147738608, '$GPGSV,1,1,01,5');
INSERT INTO "public"."device_temp_data" VALUES (1936358531091525632, '2025-06-21 17:40:24.27157', 194232147738608, '$GNGGA,,,,,,0,00,25.5,,,,,,*64');
INSERT INTO "public"."device_temp_data" VALUES (1936358535646539776, '2025-06-21 17:40:25.357744', 194232147738608, '$GNGLL,,,,,,V,NVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358540218331136, '2025-06-21 17:40:26.447742', 194232147738608, '$GNZDA,094023.000,,,,,*44');
INSERT INTO "public"."device_temp_data" VALUES (1936358545725452288, '2025-06-21 17:40:27.760152', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358550695702528, '2025-06-21 17:40:28.945334', 194232147738608, '$GNGGA,094024.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936358555187802112, '2025-06-21 17:40:30.016512', 194232147738608, '$GNGLL,,,,,094024.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936358559700873216, '2025-06-21 17:40:31.092444', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358564234915840, '2025-06-21 17:40:32.173607', 194232147738608, '$GNGSA,A,1,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358569599430656, '2025-06-21 17:40:33.45257', 194232147738608, '$GNZDA,094024.000,,,,,*43');
INSERT INTO "public"."device_temp_data" VALUES (1936358574171222016, '2025-06-21 17:40:34.542359', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358578789150720, '2025-06-21 17:40:35.64304', 194232147738608, 'T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358583335776256, '2025-06-21 17:40:36.727999', 194232147738608, '$GNGGA,094033.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936358587874013184, '2025-06-21 17:40:37.809616', 194232147738608, '$GNGLL,,,,,094033.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936358592852652032, '2025-06-21 17:40:38.99641', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358600192684032, '2025-06-21 17:40:40.746328', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358604928053248, '2025-06-21 17:40:41.875871', 194232147738608, '$5');
INSERT INTO "public"."device_temp_data" VALUES (1936358609961218048, '2025-06-21 17:40:43.075854', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358614520426496, '2025-06-21 17:40:44.162817', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358619029303296, '2025-06-21 17:40:45.237874', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358623592706048, '2025-06-21 17:40:46.325879', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936358628147720192, '2025-06-21 17:40:47.411936', 194232147738608, '$BDGSV,1,1,01,36,,,26,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358633080221696, '2025-06-21 17:40:48.587534', 194232147738608, '$GNRMC,094042.000,V,,,,,,,,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936358637580709888, '2025-06-21 17:40:49.660374', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358642123141120, '2025-06-21 17:40:50.743229', 194232147738608, '$GNZDA,094042.000,,,,,*43');
INSERT INTO "public"."device_temp_data" VALUES (1936358646632017920, '2025-06-21 17:40:51.818113', 194232147738608, '$GPTX000,V,,,,,,,,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936358651203809280, '2025-06-21 17:40:52.908943', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358655783989248, '2025-06-21 17:40:54.000027', 194232147738608, '$GNZDA,094043.000,,,,,*42');
INSERT INTO "public"."device_temp_data" VALUES (1936358660351586304, '2025-06-21 17:40:55.089357', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358665388945408, '2025-06-21 17:40:56.290213', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358669943959552, '2025-06-21 17:40:57.37663', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936358674498973696, '2025-06-21 17:40:58.462652', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936358679037210624, '2025-06-21 17:40:59.54434', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358683579641856, '2025-06-21 17:41:00.62745', 194232147738608, '$GNRMC,094052.000,V,,,,,,,,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936358688147238912, '2025-06-21 17:41:01.716261', 194232147738608, '$GNVTG,,,,,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936358693729857536, '2025-06-21 17:41:03.047004', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358698880462848, '2025-06-21 17:41:04.275205', 194232147738608, '$GNZDA,094058.000,,,,,*48');
INSERT INTO "public"."device_temp_data" VALUES (1936358704073011200, '2025-06-21 17:41:05.513601', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358711077498880, '2025-06-21 17:41:07.183274', 194232147738608, '$GNGGA,094059.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936358726650949632, '2025-06-21 17:41:10.896625', 194232147738608, '$GNGLL,,,,,094059.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936358740899000320, '2025-06-21 17:41:14.293699', 194232147738608, '$GNGSAGGA,094102.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358747232399360, '2025-06-21 17:41:15.803746', 194232147738608, '$GNGLL,,,,,094102.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936358753343500288, '2025-06-21 17:41:17.260868', 194232147738608, '$GNGSA,A,1,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936358763225280512, '2025-06-21 17:41:19.616935', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358768648515584, '2025-06-21 17:41:20.909938', 194232147738608, '$GNZDA,094115.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936358773266444288, '2025-06-21 17:41:22.010506', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358779176218624, '2025-06-21 17:41:23.419252', 194232147738608, '$GNGGA,094116.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936358788646957056, '2025-06-21 17:41:25.677718', 194232147738608, '$GNGLL,,,,,094116.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936358797178171392, '2025-06-21 17:41:27.711201', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358815347896320, '2025-06-21 17:41:32.04372', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,0,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358824839606272, '2025-06-21 17:41:34.306518', 194232147738608, '$GNRMC,094117.000,V,,,,,,,,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936358832905252864, '2025-06-21 17:41:36.229417', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358840081707008, '2025-06-21 17:41:37.940077', 194232147738608, '$GNZDA,094117.000,,,,,*42');
INSERT INTO "public"."device_temp_data" VALUES (1936358857722949632, '2025-06-21 17:41:42.146516', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358864182177792, '2025-06-21 17:41:43.686745', 194232147738608, ',25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936358879143260160, '2025-06-21 17:41:47.25375', 194232147738608, '$GNGLL,,,,,094129.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936358887657697280, '2025-06-21 17:41:49.283362', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936358893416476672, '2025-06-21 17:41:50.656601', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0,094133.000,,,,,*44');
INSERT INTO "public"."device_temp_data" VALUES (1936358911124828160, '2025-06-21 17:41:54.878634', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358936550699008, '2025-06-21 17:42:00.940721', 194232147738608, '0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936358959644536832, '2025-06-21 17:42:06.446809', 194232147738608, '$GNRMC,094150.000,V,,,,,,,,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936358964832890880, '2025-06-21 17:42:07.683216', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936358969417265152, '2025-06-21 17:42:08.776549', 194232147738608, '$GNZDA,094150.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936358974999883776, '2025-06-21 17:42:10.107954', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936358980192432128, '2025-06-21 17:42:11.345307', 194232147738608, '$GNGGA,094151.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936358984822943744, '2025-06-21 17:42:12.449359', 194232147738608, '$GNGLL,,,,,094151.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936358989336014848, '2025-06-21 17:42:13.525778', 194232147738608, '$GNGSA,52.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936358995514224640, '2025-06-21 17:42:14.998878', 194232147738608, '$GNGLL,,,,,094152.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936359004087382016, '2025-06-21 17:42:17.042858', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,,,,,,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936359010122985472, '2025-06-21 17:42:18.48178', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359014749302784, '2025-06-21 17:42:19.584739', 194232147738608, '$GNZDA,094213.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936359019283345408, '2025-06-21 17:42:20.665177', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359023859331072, '2025-06-21 17:42:21.756125', 194232147738608, '$GNGGA,094214.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936359028489842688, '2025-06-21 17:42:22.860354', 194232147738608, '$GNGLL,,,,,094214.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936359033082605568, '2025-06-21 17:42:23.955228', 194232147738608, '$GNGSA,A,1,N*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359037797003264, '2025-06-21 17:42:25.079117', 194232147738608, '$GNGGA,094221.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936359042398154752, '2025-06-21 17:42:26.176469', 194232147738608, '$GNGLL,,,,,094221.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936359046898642944, '2025-06-21 17:42:27.249124', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359051503988736, '2025-06-21 17:42:28.347486', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359055979311104, '2025-06-21 17:42:29.414496', 194232147738608, '$GPGSV,1000,V,,,,,,,,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936359060509159424, '2025-06-21 17:42:30.494919', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359065013841920, '2025-06-21 17:42:31.568853', 194232147738608, '$GNZDA,094224.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936359069640159232, '2025-06-21 17:42:32.671393', 194232147738608, '$GPTXT,01,0094231.000,V,,,,,,,,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936359074643963904, '2025-06-21 17:42:33.864681', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359079211560960, '2025-06-21 17:42:34.953122', 194232147738608, '$GNZDA,094231.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936359083699466240, '2025-06-21 17:42:36.023409', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359088317394944, '2025-06-21 17:42:37.12406', 194232147738608, '$GNGGA,094232.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359093585440768, '2025-06-21 17:42:38.380601', 194232147738608, '$GNGLL,,,,,094232.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359098148843520, '2025-06-21 17:42:39.468653', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359102733217792, '2025-06-21 17:42:40.561025', 194232147738608, '$GNGSA,A,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359107405672448, '2025-06-21 17:42:41.675903', 194232147738608, '$GNZDA,094232.000,,,,,*46');
INSERT INTO "public"."device_temp_data" VALUES (1936359112052961280, '2025-06-21 17:42:42.783421', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359116532477952, '2025-06-21 17:42:43.851188', 194232147738608, '$GNGGA,094233.000,,OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359121074909184, '2025-06-21 17:42:44.934054', 194232147738608, '$GNGGA,094241.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936359125571203072, '2025-06-21 17:42:46.006228', 194232147738608, '$GNGLL,,,,,094241.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936359131359342592, '2025-06-21 17:42:47.38613', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359135872413696, '2025-06-21 17:42:48.462044', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0,,*42');
INSERT INTO "public"."device_temp_data" VALUES (1936359140398067712, '2025-06-21 17:42:49.541032', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359144911138816, '2025-06-21 17:42:50.617646', 194232147738608, '$GN*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936359149843640320, '2025-06-21 17:42:51.793378', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359154344128512, '2025-06-21 17:42:52.866075', 194232147738608, '$GNZDA,094248.000,,,,,*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936359158903336960, '2025-06-21 17:42:53.953253', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359164313989120, '2025-06-21 17:42:55.243228', 194232147738608, '$GNGGA,094249.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936359169728835584, '2025-06-21 17:42:56.534886', 194232147738608, '$GNGLL,,,,,094249.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936359174694891520, '2025-06-21 17:42:57.718888', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359179207962624, '2025-06-21 17:42:58.794779', 194232147738608, '$GNGSA,A,1,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359183788142592, '2025-06-21 17:42:59.88674', 194232147738608, '$GNZDA,094249.000,,,,,*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936359197667094528, '2025-06-21 17:43:03.195338', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359202272440320, '2025-06-21 17:43:04.293091', 194232147738608, ',,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936359206856814592, '2025-06-21 17:43:05.386321', 194232147738608, '$GNGLL,,,,,094259.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936359220760932352, '2025-06-21 17:43:08.701832', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359225328529408, '2025-06-21 17:43:09.790189', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359229845794816, '2025-06-21 17:43:10.867406', 194232147738608, '$GPGSV,1,1,01,32,,,23,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936359262737526784, '2025-06-21 17:43:18.709037', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359267250597888, '2025-06-21 17:43:19.785578', 194232147738608, '$GNRMC,094259,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359271818194944, '2025-06-21 17:43:20.874266', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359288146620416, '2025-06-21 17:43:24.767663', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359292718411776, '2025-06-21 17:43:25.857396', 194232147738608, '$GNRMC,0943000,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936359297277620224, '2025-06-21 17:43:26.944702', 194232147738608, '$GNGLL,,,,,094320.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936359301887160320, '2025-06-21 17:43:28.043949', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359310980411392, '2025-06-21 17:43:30.211738', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359315552202752, '2025-06-21 17:43:31.301671', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359320295960576, '2025-06-21 17:43:32.432491', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359324930666496, '2025-06-21 17:43:33.537778', 194232147738608, '$GN,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359329544400896, '2025-06-21 17:43:34.637702', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359346699104256, '2025-06-21 17:43:38.727096', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359351438667776, '2025-06-21 17:43:39.857918', 194232147738608, '$TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359356085956608, '2025-06-21 17:43:40.965106', 194232147738608, '$GNGGA,094334.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936359360833908736, '2025-06-21 17:43:42.097191', 194232147738608, '$GNGLL,,,,,094334.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936359403334791168, '2025-06-21 17:43:52.230215', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359407864639488, '2025-06-21 17:43:53.310687', 194232147738608, '$GPGSV,1,1,01,32*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359412386099200, '2025-06-21 17:43:54.388087', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936359416936919040, '2025-06-21 17:43:55.47383', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359421529681920, '2025-06-21 17:43:56.568051', 194232147738608, '$GNRMC,094340.000,V,,,,,,,,,00,V,,,,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936359426176970752, '2025-06-21 17:43:57.676134', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359430752956416, '2025-06-21 17:43:58.76782', 194232147738608, '$GNZDA,094353.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936359435307970560, '2025-06-21 17:43:59.853356', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359444308946944, '2025-06-21 17:44:01.999535', 194232147738608, '$GNGGA,094354.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936359448880738304, '2025-06-21 17:44:03.089913', 194232147738608, '$GNGLL,,,,,094354.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936359453511249920, '2025-06-21 17:44:04.193514', 194232147738608, '3,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936359468384251904, '2025-06-21 17:44:07.739542', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359472981209088, '2025-06-21 17:44:08.83524', 194232147738608, '$GNRMC,094400.000,V,,,,,,,,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936359477569777664, '2025-06-21 17:44:09.929725', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359482120597504, '2025-06-21 17:44:11.014929', 194232147738608, '$GNZDA,094400.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936359486730137600, '2025-06-21 17:44:12.113746', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359491293540352, '2025-06-21 17:44:13.201777', 194232147738608, '$GNGGA,094401.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936359495848554496, '2025-06-21 17:44:14.287265', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359500428734464, '2025-06-21 17:44:15.379595', 194232147738608, '$GNGGA,094404.000,,,,,0,00,25.5,,,,V,,,,,,,,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359505218629632, '2025-06-21 17:44:16.521797', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359509735895040, '2025-06-21 17:44:17.598231', 194232147738608, '$GNZDA,094414.000,,,,,*44');
INSERT INTO "public"."device_temp_data" VALUES (1936359514295103488, '2025-06-21 17:44:18.685443', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359518824951808, '2025-06-21 17:44:19.765619', 194232147738608, '$GNGGA,094415.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936359523367383040, '2025-06-21 17:44:20.848171', 194232147738608, '$GNGLL,,,,,094415.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936359527901425664, '2025-06-21 17:44:21.929432', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359532599046144, '2025-06-21 17:44:23.04908', 194232147738608, '$GNGSA,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359539880357888, '2025-06-21 17:44:24.785184', 194232147738608, '$GNZDA,094415.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936359544464732160, '2025-06-21 17:44:25.878945', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359549132992512, '2025-06-21 17:44:26.991002', 194232147738608, ',,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936359553717366784, '2025-06-21 17:44:28.084561', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359558343684096, '2025-06-21 17:44:29.187784', 194232147738608, '$GNZDA,094423.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936359562860949504, '2025-06-21 17:44:30.264497', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359567462100992, '2025-06-21 17:44:31.361544', 194232147738608, '$GNGGA,094424.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936359572046475264, '2025-06-21 17:44:32.454482', 194232147738608, '$GNGLL,,,,,094424.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936359576769261568, '2025-06-21 17:44:33.580441', 194232147738608, '$GNGSA,A,1,,,,,,,,000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359581961809920, '2025-06-21 17:44:34.818397', 194232147738608, '$GNGLL,,,,,094425.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359586537795584, '2025-06-21 17:44:35.909414', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359591092809728, '2025-06-21 17:44:36.995283', 194232147738608, '$5');
INSERT INTO "public"."device_temp_data" VALUES (1936359595643629568, '2025-06-21 17:44:38.080718', 194232147738608, '$GNGGA,094434.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359600211226624, '2025-06-21 17:44:39.169741', 194232147738608, '$GNGLL,,,,,094434.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359605118562304, '2025-06-21 17:44:40.339778', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359610038480896, '2025-06-21 17:44:41.51223', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359614731907072, '2025-06-21 17:44:42.631175', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,2,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359619270144000, '2025-06-21 17:44:43.713897', 194232147738608, '$GNZDA,094441.000,,,,,*44');
INSERT INTO "public"."device_temp_data" VALUES (1936359623892267008, '2025-06-21 17:44:44.815166', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359628623441920, '2025-06-21 17:44:45.943629', 194232147738608, '$GNGGA,094442.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936359633925042176, '2025-06-21 17:44:47.207651', 194232147738608, '$GNGLL,,,,,094442.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936359645975277568, '2025-06-21 17:44:50.08027', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359651218157568, '2025-06-21 17:44:51.330237', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359655794143232, '2025-06-21 17:44:52.421297', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359660349157376, '2025-06-21 17:44:53.507685', 194232147738608, '$GPGSV,1,1,01,32,,,24,5');
INSERT INTO "public"."device_temp_data" VALUES (1936359664887394304, '2025-06-21 17:44:54.589112', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359669425631232, '2025-06-21 17:44:55.671117', 194232147738608, '$GNGGA,094452.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359674081308672, '2025-06-21 17:44:56.78193', 194232147738608, '$GNGLL,,,,,094452.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359678653100032, '2025-06-21 17:44:57.871979', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359683250057216, '2025-06-21 17:44:58.967785', 194232147738608, '000,V,,,,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936359687800877056, '2025-06-21 17:45:00.052821', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359692427194368, '2025-06-21 17:45:01.155021', 194232147738608, '$GNZDA,094454.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936359696961236992, '2025-06-21 17:45:02.236718', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359701570777088, '2025-06-21 17:45:03.335977', 194232147738608, '$GNGGA,094455.000,,,,,0,00,25.5,,,,,,MC,094458.000,V,,,,,,,,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936359706880765952, '2025-06-21 17:45:04.601253', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359711620329472, '2025-06-21 17:45:05.731614', 194232147738608, '$GNZDA,094458.000,,,,,*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936359716154372096, '2025-06-21 17:45:06.812835', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359720692609024, '2025-06-21 17:45:07.894608', 194232147738608, '$$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359725235040256, '2025-06-21 17:45:08.977049', 194232147738608, '$GNZDA,094503.000,,,,,*43');
INSERT INTO "public"."device_temp_data" VALUES (1936359729819414528, '2025-06-21 17:45:10.070161', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359734319902720, '2025-06-21 17:45:11.143515', 194232147738608, '$GNGGA,094504.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936359738841362432, '2025-06-21 17:45:12.22165', 194232147738608, '$GNGLL,,,,,094504.0');
INSERT INTO "public"."device_temp_data" VALUES (1936359743505428480, '2025-06-21 17:45:13.333542', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359748127551488, '2025-06-21 17:45:14.43597', 194232147738608, '$GPGSV,1,1,01,32,,,23,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936359752711925760, '2025-06-21 17:45:15.528568', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359757266939904, '2025-06-21 17:45:16.614313', 194232147738608, '$GNRMC,094507.000,V,,2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359761817759744, '2025-06-21 17:45:17.699562', 194232147738608, '$GNZDA,094516.000,,,,,*47');
INSERT INTO "public"."device_temp_data" VALUES (1936359766381162496, '2025-06-21 17:45:18.787996', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359770940370944, '2025-06-21 17:45:19.874839', 194232147738608, '$GNGGA,094517.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359775554105344, '2025-06-21 17:45:20.974735', 194232147738608, '$GNGLL,,,,,094517.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359780121702400, '2025-06-21 17:45:22.063835', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359784685105152, '2025-06-21 17:45:23.151985', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359789282062336, '2025-06-21 17:45:24.247408', 194232147738608, '$GPGSV,1,1,01,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936359793820299264, '2025-06-21 17:45:25.329966', 194232147738608, '$BDG519.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936359798400479232, '2025-06-21 17:45:26.421641', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359803106488320, '2025-06-21 17:45:27.543397', 194232147738608, '$GNGSA,A,1,,,,,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936359807678279680, '2025-06-21 17:45:28.633591', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359812279431168, '2025-06-21 17:45:29.730395', 194232147738608, '$GNZDA,094525.000,,,,,*47');
INSERT INTO "public"."device_temp_data" VALUES (1936359816851222528, '2025-06-21 17:45:30.820611', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359821607563264, '2025-06-21 17:45:31.954933', 194232147738608, '$GNGGA,094526.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936359826158383104, '2025-06-21 17:45:33.039797', 194232147738608, '$GNGLL,,,,,094526.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936359830751145984, '2025-06-21 17:45:34.134844', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359835314548736, '2025-06-21 17:45:35.222693', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359839919894528, '2025-06-21 17:45:36.320851', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359849113808896, '2025-06-21 17:45:38.512361', 194232147738608, '$GNRMC,094531.000,V,,,,,,,,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936359853710766080, '2025-06-21 17:45:39.608275', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359858278363136, '2025-06-21 17:45:40.697259', 194232147738608, '$GNZDA,094531.000,,,,,*42');
INSERT INTO "public"."device_temp_data" VALUES (1936359863110201344, '2025-06-21 17:45:41.849596', 194232147738608, '$GPTXT,01,0,,,,,,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936359867702964224, '2025-06-21 17:45:42.944692', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359872375418880, '2025-06-21 17:45:44.058031', 194232147738608, '$GNZDA,094534.000,,,,,*47');
INSERT INTO "public"."device_temp_data" VALUES (1936359876993347584, '2025-06-21 17:45:45.159782', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359881569333248, '2025-06-21 17:45:46.250721', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936359886187261952, '2025-06-21 17:45:47.35192', 194232147738608, '$GNGLL,,,,,094542.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936359890893271040, '2025-06-21 17:45:48.47325', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359895544754176, '2025-06-21 17:45:49.582947', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359900225597440, '2025-06-21 17:45:50.698071', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359904809971712, '2025-06-21 17:45:51.791569', 194232147738608, '$BDGSV,1,1,0GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359909406928896, '2025-06-21 17:45:52.887866', 194232147738608, '$GNZDA,094545.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936359914050023424, '2025-06-21 17:45:53.994307', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359918726672384, '2025-06-21 17:45:55.109939', 194232147738608, '$GNGGA,09454V,,,,,,,,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936359923311046656, '2025-06-21 17:45:56.202666', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936359927878643712, '2025-06-21 17:45:57.291336', 194232147738608, '$GNZDA,094554.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936359932504961024, '2025-06-21 17:45:58.394922', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359937122889728, '2025-06-21 17:45:59.49506', 194232147738608, '$GNGGA,094555.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936359941724041216, '2025-06-21 17:46:00.592275', 194232147738608, '$GNGLL,,,,,094555.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936359946308415488, '2025-06-21 17:46:01.685141', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359950850846720, '2025-06-21 17:46:02.768164', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,294555.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936359955401666560, '2025-06-21 17:46:03.8538', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359959952486400, '2025-06-21 17:46:04.938798', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936359964553637888, '2025-06-21 17:46:06.035606', 194232147738608, '$GNGLL,,,,,094603.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936359969138012160, '2025-06-21 17:46:07.128472', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936359973676249088, '2025-06-21 17:46:08.210401', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936359978243846144, '2025-06-21 17:46:09.299702', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936359982807248896, '2025-06-21 17:46:10.387451', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936359987425177600, '2025-06-21 17:46:11.488235', 194232147738608, '$GNRMC,094603.000,V,,,,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936359992118603776, '2025-06-21 17:46:12.607349', 194232147738608, '$GNVTG,,,,,V,,,,,,,,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936359996715560960, '2025-06-21 17:46:13.703636', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360001257992192, '2025-06-21 17:46:14.786553', 194232147738608, '$GNZDA,094607.000,,,,,*44');
INSERT INTO "public"."device_temp_data" VALUES (1936360005833977856, '2025-06-21 17:46:15.877495', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360010418352128, '2025-06-21 17:46:16.970434', 194232147738608, '$GNGGA,0946094612.000,V,,,,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936360015006920704, '2025-06-21 17:46:18.064488', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360019738095616, '2025-06-21 17:46:19.192504', 194232147738608, '$GNZDA,094612.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936360024351830016, '2025-06-21 17:46:20.292005', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360029938642944, '2025-06-21 17:46:21.624868', 194232147738608, '$GNGGA,094613.000,,,,,0,00,25.5,,GNZDA,094620.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936360034611097600, '2025-06-21 17:46:22.738659', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360039254192128, '2025-06-21 17:46:23.845232', 194232147738608, '$GNGGA,094621.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936360043834372096, '2025-06-21 17:46:24.937172', 194232147738608, '$GNGLL,,,,,094621.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936360048431329280, '2025-06-21 17:46:26.033037', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360053162504192, '2025-06-21 17:46:27.161218', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360057839153152, '2025-06-21 17:46:28.276069', 194232147738608, '$GPGS,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936360063253999616, '2025-06-21 17:46:29.567416', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360067800625152, '2025-06-21 17:46:30.651212', 194232147738608, ',,,,,,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936360072401776640, '2025-06-21 17:46:31.748167', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360077023899648, '2025-06-21 17:46:32.850925', 194232147738608, '$GNZDA,094628.000,,,,,*49');
INSERT INTO "public"."device_temp_data" VALUES (1936360081599885312, '2025-06-21 17:46:33.941091', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360087488688128, '2025-06-21 17:46:35.345566', 194232147738608, '$GNGGA,094629.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936360092203085824, '2025-06-21 17:46:36.469979', 194232147738608, '$GNGLL,,,,,094629.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936360096883929088, '2025-06-21 17:46:37.585237', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360101480886272, '2025-06-21 17:46:38.681832', 194232147738608, '$GNGTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360106090426368, '2025-06-21 17:46:39.780161', 194232147738608, '$GNZDA,094629.000,,,,,*48');
INSERT INTO "public"."device_temp_data" VALUES (1936360110733520896, '2025-06-21 17:46:40.887088', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360115905097728, '2025-06-21 17:46:42.120039', 194232147738608, '4639.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936360120502054912, '2025-06-21 17:46:43.216938', 194232147738608, '$GNGLL,,,,,094639.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936360125136760832, '2025-06-21 17:46:44.321939', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360129683386368, '2025-06-21 17:46:45.4053', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360134230011904, '2025-06-21 17:46:46.489695', 194232147738608, '$GPGSV,1,1,01,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936360138835357696, '2025-06-21 17:46:47.587032', 194232147738608, '$A,A,1,,,,,,,,,,,,,25.5,25.5,25N*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360143423926272, '2025-06-21 17:46:48.681906', 194232147738608, '$GNGGA,094648.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936360148025077760, '2025-06-21 17:46:49.778256', 194232147738608, '$GNGLL,,,,,094648.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936360152613646336, '2025-06-21 17:46:50.872187', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360157164466176, '2025-06-21 17:46:51.9575', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360161702703104, '2025-06-21 17:46:53.039936', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936360166316437504, '2025-06-21 17:46:54.139969', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360170888228864, '2025-06-21 17:46:55.229601', 194232147738608, '$GNRMC,094648.000,V,,,,,,,,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360175489380352, '2025-06-21 17:46:56.326873', 194232147738608, '$GNVTG,,,,,,,,,,,,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936360180094726144, '2025-06-21 17:46:57.424177', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360184641351680, '2025-06-21 17:46:58.508384', 194232147738608, '$GNZDA,094656.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936360189221531648, '2025-06-21 17:46:59.600486', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360193818488832, '2025-06-21 17:47:00.696468', 194232147738608, '$GNGGA,094657.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936360198411251712, '2025-06-21 17:47:01.791275', 194232147738608, '$GNGLL,,,,,094657.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936360203456999424, '2025-06-21 17:47:02.994302', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360208125259776, '2025-06-21 17:47:04.107912', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.94659.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360212768354304, '2025-06-21 17:47:05.214364', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360217335951360, '2025-06-21 17:47:06.303521', 194232147738608, '$GNGGA,094700.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936360221920325632, '2025-06-21 17:47:07.396104', 194232147738608, '$GNGLL,,,,,XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360226588585984, '2025-06-21 17:47:08.509732', 194232147738608, '$GNGGA,094705.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936360231185543168, '2025-06-21 17:47:09.605247', 194232147738608, '$GNGLL,,,,,094705.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936360235744751616, '2025-06-21 17:47:10.692004', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360240392040448, '2025-06-21 17:47:11.80083', 194232147738608, '$GNGSA');
INSERT INTO "public"."device_temp_data" VALUES (1936360244909305856, '2025-06-21 17:47:12.87785', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360249481097216, '2025-06-21 17:47:13.96734', 194232147738608, '$GNZDA,094707.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936360254094831616, '2025-06-21 17:47:15.067707', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360258695983104, '2025-06-21 17:47:16.164615', 194232147738608, '$GNGGA,094708.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936360263255191552, '2025-06-21 17:47:17.251951', 194232147738608, '$GNGLL,,,,,3');
INSERT INTO "public"."device_temp_data" VALUES (1936360267923451904, '2025-06-21 17:47:18.364455', 194232147738608, '$GNGLL,,,,,094712.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936360272537186304, '2025-06-21 17:47:19.464088', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360277083811840, '2025-06-21 17:47:20.548883', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360281655603200, '2025-06-21 17:47:21.638607', 194232147738608, '*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360286273531904, '2025-06-21 17:47:22.73923', 194232147738608, '$GNZDA,094720.000,,,,,*40');
INSERT INTO "public"."device_temp_data" VALUES (1936360290799185920, '2025-06-21 17:47:23.818888', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360295370977280, '2025-06-21 17:47:24.908635', 194232147738608, '$GNGGA,094721.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936360299959545856, '2025-06-21 17:47:26.002226', 194232147738608, '$GNGLL,,,,,094721.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936360304619417600, '2025-06-21 17:47:27.113028', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360309212180480, '2025-06-21 17:47:28.208345', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360313817526272, '2025-06-21 17:47:29.306451', 194232147738608, '$GPGSV,1,1,01,32,,,21,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936360318372540416, '2025-06-21 17:47:30.392788', 194232147738608, '$BD$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360322927554560, '2025-06-21 17:47:31.478399', 194232147738608, '$GPGSV,1,1,01,32,,,25,1');
INSERT INTO "public"."device_temp_data" VALUES (1936360327537094656, '2025-06-21 17:47:32.577126', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360332104691712, '2025-06-21 17:47:33.666184', 194232147738608, '$GNGGA,094731.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936360336714231808, '2025-06-21 17:47:34.765919', 194232147738608, '$GNGLL,,,,,094731.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936360341269245952, '2025-06-21 17:47:35.851056', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360345820065792, '2025-06-21 17:47:36.936097', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,094732.000,V,,,,,,,,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936360350417022976, '2025-06-21 17:47:38.032628', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360354951065600, '2025-06-21 17:47:39.113236', 194232147738608, '$GNZDA,094732.000,,,,,*43');
INSERT INTO "public"."device_temp_data" VALUES (1936360370562265088, '2025-06-21 17:47:42.835436', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360379823288320, '2025-06-21 17:47:45.043754', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360384374108160, '2025-06-21 17:47:46.128854', 194232147738608, '$GNZDA,094737.000,,,,,*46');
INSERT INTO "public"."device_temp_data" VALUES (1936360388895567872, '2025-06-21 17:47:47.206186', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360393463164928, '2025-06-21 17:47:48.295565', 194232147738608, '$GNGGA,094738.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936360398060122112, '2025-06-21 17:47:49.391093', 194232147738608, '$GNGLL,,,,,094738.000$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360402699022336, '2025-06-21 17:47:50.497727', 194232147738608, '$GNGGA,094747.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936360407329533952, '2025-06-21 17:47:51.601672', 194232147738608, '$GNGLL,,,,,094747.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936360411880353792, '2025-06-21 17:47:52.686566', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360416456339456, '2025-06-21 17:47:53.7777', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360421044908032, '2025-06-21 17:47:54.871117', 194232147738608, '$GNZDA,094749.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360425574756352, '2025-06-21 17:47:55.951551', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360430251405312, '2025-06-21 17:47:57.066284', 194232147738608, '$GNGGA,094750.000,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360434793836544, '2025-06-21 17:47:58.149674', 194232147738608, '$GNZDA,094756.000,,,,,*41');
INSERT INTO "public"."device_temp_data" VALUES (1936360439353044992, '2025-06-21 17:47:59.236431', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360443933224960, '2025-06-21 17:48:00.327641', 194232147738608, '$GNGGA,094757.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936360448505016320, '2025-06-21 17:48:01.418272', 194232147738608, '$GNGLL,,,,,094757.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936360453378797568, '2025-06-21 17:48:02.580199', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360457975754752, '2025-06-21 17:48:03.676487', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360462534963200, '2025-06-21 17:48:04.763377', 194232147738608, '$GPGSV,1XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360467207417856, '2025-06-21 17:48:05.877303', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936360471783403520, '2025-06-21 17:48:06.968266', 194232147738608, '$GNGLL,,,,,094805.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936360476367777792, '2025-06-21 17:48:08.061798', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360480977317888, '2025-06-21 17:48:09.160471', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360485603635200, '2025-06-21 17:48:10.263308', 194232147738608, '$GPGSV,1,1,01,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936360490179620864, '2025-06-21 17:48:11.354726', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360494776578048, '2025-06-21 17:48:12.450265', 194232147738608, '$GNRMC,094805.000,V,,,,,,,,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936360499449032704, '2025-06-21 17:48:13.564134', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360503999852544, '2025-06-21 17:48:14.649586', 194232147738608, '$GNZDA,094805.000,,NRMC,094808.000,V,,,,,,,,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936360508575838208, '2025-06-21 17:48:15.740614', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360513118269440, '2025-06-21 17:48:16.823346', 194232147738608, '$GNZDA,094808.000,,,,,*45');
INSERT INTO "public"."device_temp_data" VALUES (1936360517736198144, '2025-06-21 17:48:17.92472', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360522324766720, '2025-06-21 17:48:19.018793', 194232147738608, ',01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360526942695424, '2025-06-21 17:48:20.119402', 194232147738608, '$GNGGA,094815.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936360531548041216, '2025-06-21 17:48:21.217694', 194232147738608, '$GNGLL,,,,,094815.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936360536203718656, '2025-06-21 17:48:22.327968', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360540851007488, '2025-06-21 17:48:23.435347', 194232147738608, '$GNPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360545447964672, '2025-06-21 17:48:24.531554', 194232147738608, '$GNGGA,094821.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936360550007173120, '2025-06-21 17:48:25.618333', 194232147738608, '$GNGLL,,,,,094821.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936360554587353088, '2025-06-21 17:48:26.710658', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1,,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936360559142367232, '2025-06-21 17:48:27.79627', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360563877736448, '2025-06-21 17:48:28.925023', 194232147738608, '$GNZDA,094823.000,,,,,*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936360568491470848, '2025-06-21 17:48:30.024842', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360573075845120, '2025-06-21 17:48:31.118439', 194232147738608, '$GNGGA,094824.000,,,,F');
INSERT INTO "public"."device_temp_data" VALUES (1936360577614082048, '2025-06-21 17:48:32.200911', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360582206844928, '2025-06-21 17:48:33.295472', 194232147738608, '$GNZDA,094830.000,,,,,*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936360586803802112, '2025-06-21 17:48:34.391098', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360591375593472, '2025-06-21 17:48:35.481589', 194232147738608, '$GNGGA,094831.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936360595972550656, '2025-06-21 17:48:36.577056', 194232147738608, '$GNGLL,,,,,094831.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936360600531759104, '2025-06-21 17:48:37.664793', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360605090967552, '2025-06-21 17:48:38.751433', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.094831.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360609641787392, '2025-06-21 17:48:39.836457', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360614247133184, '2025-06-21 17:48:40.934195', 194232147738608, '94839.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936360619053805568, '2025-06-21 17:48:42.080083', 194232147738608, '$GNGLL,,,,,094839.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936360623726260224, '2025-06-21 17:48:43.194972', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360628662956032, '2025-06-21 17:48:44.371968', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360633188610048, '2025-06-21 17:48:45.450879', 194232147738608, '$GPGSV,1,1,01,32,,,27,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936360637714264064, '2025-06-21 17:48:46.529614', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360642365747200, '2025-06-21 17:48:47.638468', 194232147738608, '$GNRMC,094839.000,V,,,,GNRMC,094843.000,V,,,,,,,,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936360646878818304, '2025-06-21 17:48:48.714269', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360651412860928, '2025-06-21 17:48:49.795578', 194232147738608, '$GNZDA,094843.000,,,,,*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936360655967875072, '2025-06-21 17:48:50.881936', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360660766158848, '2025-06-21 17:48:52.025389', 194232147738608, '$GNG,,,,*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936360666856288256, '2025-06-21 17:48:53.477008', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360672539570176, '2025-06-21 17:48:54.832395', 194232147738608, '$GNGGA,094848.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936360678885552128, '2025-06-21 17:48:56.345814', 194232147738608, '$GNGLL,,,,,094848.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936360683474120704, '2025-06-21 17:48:57.439472', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,.000,V,,,,,,,,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936360688050106368, '2025-06-21 17:48:58.530744', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360692689006592, '2025-06-21 17:48:59.636352', 194232147738608, '$GNZDA,094853.000,,,,,*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936360697231437824, '2025-06-21 17:49:00.719579', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360701807423488, '2025-06-21 17:49:01.810646', 194232147738608, '$GNGGA,094854.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936360706395992064, '2025-06-21 17:49:02.904021', 194232147738608, '$GNGLL,,,,,094854NRMC,094857.000,V,,,,,,,,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360710984560640, '2025-06-21 17:49:03.998735', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360715514408960, '2025-06-21 17:49:05.078433', 194232147738608, '$GNZDA,094857.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360720090394624, '2025-06-21 17:49:06.169539', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360724653797376, '2025-06-21 17:49:07.25768', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936360729221394432, '2025-06-21 17:49:08.346716', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360733793185792, '2025-06-21 17:49:09.436379', 194232147738608, '$GNRMC,094903.000,V,,,,,,,,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360738419503104, '2025-06-21 17:49:10.539259', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360742978711552, '2025-06-21 17:49:11.626517', 194232147738608, '$GNZDA,094903.000,,,,,*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360747739246592, '2025-06-21 17:49:12.76126', 194232147738608, '$GPTXT,0V,,,,,,,,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936360752722079744, '2025-06-21 17:49:13.949134', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360757306454016, '2025-06-21 17:49:15.042904', 194232147738608, '$GNZDA,094906.000,,,,,*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936360761861468160, '2025-06-21 17:49:16.128244', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360766475202560, '2025-06-21 17:49:17.228369', 194232147738608, ',01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360771084742656, '2025-06-21 17:49:18.327309', 194232147738608, '$GNGGA,094913.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936360775673311232, '2025-06-21 17:49:19.421435', 194232147738608, '$GNGLL,,,,,094913.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936360780274462720, '2025-06-21 17:49:20.518595', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360784925945856, '2025-06-21 17:49:21.627421', 194232147738608, '$GNGSA,A,1,,,,,,,,,,EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360789430628352, '2025-06-21 17:49:22.701767', 194232147738608, '$GNGGA,094917.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936360794048557056, '2025-06-21 17:49:23.802544', 194232147738608, '$GNGLL,,,,,094917.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936360798628737024, '2025-06-21 17:49:24.894693', 194232147738608, '$GNGSA,A,1,1,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360803242471424, '2025-06-21 17:49:25.994151', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360807831040000, '2025-06-21 17:49:27.088932', 194232147738608, '$GNGGA,094922.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936360812423802880, '2025-06-21 17:49:28.183027', 194232147738608, '$GNGLL,,,,,094922.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936360817003982848, '2025-06-21 17:49:29.275187', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360821617717248, '2025-06-21 17:49:30.375711', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360826214674432, '2025-06-21 17:49:31.47146', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936360830845186048, '2025-06-21 17:49:32.575909', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360835375034368, '2025-06-21 17:49:33.655924', 194232147738608, '$GNRMC,094925.000,V,,,,,,1,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360839896494080, '2025-06-21 17:49:34.733129', 194232147738608, '$GNGGA,094931.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936360844392787968, '2025-06-21 17:49:35.805705', 194232147738608, '$GNGLL,,,,,094931.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936360849014910976, '2025-06-21 17:49:36.907195', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360853607673856, '2025-06-21 17:49:38.002527', 194232147738608, '$GNG,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936360858254962688, '2025-06-21 17:49:39.110484', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360863002914816, '2025-06-21 17:49:40.242408', 194232147738608, '$GNGGA,094933.000,,,,,0,00,2500,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936360867780227072, '2025-06-21 17:49:41.381277', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360872503013376, '2025-06-21 17:49:42.507137', 194232147738608, '$GNGGA,094940.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936360877120942080, '2025-06-21 17:49:43.608069', 194232147738608, '$GNGLL,,,,,094940.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936360881730482176, '2025-06-21 17:49:44.707364', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360886302273536, '2025-06-21 17:49:45.797872', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360890869870592, '2025-06-21 17:49:46.885307', 194232147738608, '$GPGSV,1,1,,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936360895450050560, '2025-06-21 17:49:47.978003', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360900072173568, '2025-06-21 17:49:49.080495', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360904639770624, '2025-06-21 17:49:50.169813', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936360909194784768, '2025-06-21 17:49:51.255063', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936360913749798912, '2025-06-21 17:49:52.341607', 194232147738608, '$GNRMC,094947.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936360918388699136, '2025-06-21 17:49:53.447097', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360922947907584, '2025-06-21 17:49:54.534846', 194232147738608, '$GNZDA,094947.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936360927498727424, '2025-06-21 17:49:55.619909', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360932104073216, '2025-06-21 17:49:56.717517', 194232147738608, '$GNZDA,094948.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936360936680058880, '2025-06-21 17:49:57.808806', 194232147738608, '$GPTXTPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360941268627456, '2025-06-21 17:49:58.902504', 194232147738608, '$GNGGA,094956.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936360945802670080, '2025-06-21 17:49:59.983807', 194232147738608, '$GNGLL,,,,,094956.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936360950391238656, '2025-06-21 17:50:01.077699', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936360954967224320, '2025-06-21 17:50:02.168591', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936360959551598592, '2025-06-21 17:50:03.261572', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936360964169527296, '2025-06-21 17:50:04.362965', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936360969127194624, '2025-06-21 17:50:05.544363', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360973917089792, '2025-06-21 17:50:06.686107', 194232147738608, '$GNGGA,094957.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936360978853785600, '2025-06-21 17:50:07.863845', 194232147738608, '$GNGLL,,,,,09495GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936360984033751040, '2025-06-21 17:50:09.098124', 194232147738608, '$GNZDA,095003.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936360988588765184, '2025-06-21 17:50:10.184068', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936360993185722368, '2025-06-21 17:50:11.280923', 194232147738608, '$GNGGA,095004.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936360997782679552, '2025-06-21 17:50:12.37649', 194232147738608, '$GNGLL,,,,,095004.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936361002388025344, '2025-06-21 17:50:13.474782', 194232147738608, ',,,,,,210625,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936361006997565440, '2025-06-21 17:50:14.573974', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361011565162496, '2025-06-21 17:50:15.662156', 194232147738608, '$GNZDA,095005.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936361016136953856, '2025-06-21 17:50:16.752721', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361020675190784, '2025-06-21 17:50:17.834225', 194232147738608, '210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936361025284730880, '2025-06-21 17:50:18.933338', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361029848133632, '2025-06-21 17:50:20.02149', 194232147738608, '$GNZDA,095012.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936361034403147776, '2025-06-21 17:50:21.107035', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361039000104960, '2025-06-21 17:50:22.203741', 194232147738608, '$GNGGA,095013.000,,,,,0,00,25.5NA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361043622227968, '2025-06-21 17:50:23.305577', 194232147738608, '$GNGGA,09501GNZDA,095022.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361048181436416, '2025-06-21 17:50:24.392568', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361052753227776, '2025-06-21 17:50:25.482417', 194232147738608, '$GNGGA,095023.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936361057312436224, '2025-06-21 17:50:26.569423', 194232147738608, '$GNGLL,,,,,095023.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936361061913587712, '2025-06-21 17:50:27.666129', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361066560876544, '2025-06-21 17:50:28.774484', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361071145250816, '2025-06-21 17:50:29.867753', 194232147738608, '$GPGSV,1,1,01,,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936361075738013696, '2025-06-21 17:50:30.962622', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361080293027840, '2025-06-21 17:50:32.048573', 194232147738608, '.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361084839653376, '2025-06-21 17:50:33.13249', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361089390473216, '2025-06-21 17:50:34.217862', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936361093970653184, '2025-06-21 17:50:35.309825', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361098542444544, '2025-06-21 17:50:36.399569', 194232147738608, '$GNRMC,095030.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936361103248453632, '2025-06-21 17:50:37.521632', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361107769913344, '2025-06-21 17:50:38.599982', 194232147738608, '$GNZDA,095030.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936361112350093312, '2025-06-21 17:50:39.691436', 194232147738608, '$GPT,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361117039325184, '2025-06-21 17:50:40.809331', 194232147738608, '$GNZDA,095035.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936361122269622272, '2025-06-21 17:50:42.056239', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361126912716800, '2025-06-21 17:50:43.163469', 194232147738608, '$GNGGA,095036.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936361131505479680, '2025-06-21 17:50:44.258527', 194232147738608, '$GNGLL,,,,,095036.000,25,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936361136266014720, '2025-06-21 17:50:45.393834', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361140804251648, '2025-06-21 17:50:46.475719', 194232147738608, '$GNGGA,095040.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936361145392820224, '2025-06-21 17:50:47.569433', 194232147738608, '$GNGLL,,,,,095040.000,V,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361149952028672, '2025-06-21 17:50:48.656314', 194232147738608, '$GNGGA,095047.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936361154477682688, '2025-06-21 17:50:49.735043', 194232147738608, '$GNGLL,,,,,095047.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936361159045279744, '2025-06-21 17:50:50.824687', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361163642236928, '2025-06-21 17:50:51.920446', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361168222416896, '2025-06-21 17:50:53.0122', 194232147738608, '$GPGSV,1,1,01,32,,,26,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936361172873900032, '2025-06-21 17:50:54.12028', 194232147738608, '$BDGSV,1,1,01,45,,,2TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361177496023040, '2025-06-21 17:50:55.223963', 194232147738608, '$GNGGA,095048$GNGGA,095055.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936361182097174528, '2025-06-21 17:50:56.320653', 194232147738608, '$GNGLL,,,,,095055.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936361186660577280, '2025-06-21 17:50:57.408222', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361191190425600, '2025-06-21 17:50:58.48813', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361195724468224, '2025-06-21 17:50:59.569178', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936361200321425408, '2025-06-21 17:51:00.664144', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361204922576896, '2025-06-21 17:51:01.762237', 194232147738608, '$GNRMC,095055.000,V,,,,,,,210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936361209456619520, '2025-06-21 17:51:02.84377', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361214024216576, '2025-06-21 17:51:03.932245', 194232147738608, '$GNZDA,095055.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361218591813632, '2025-06-21 17:51:05.021324', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361223138439168, '2025-06-21 17:51:06.105797', 194232147738608, '$GNGGA,095102.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936361227668287488, '2025-06-21 17:51:07.185861', 194232147738608, '$GNGLL,,,,,095102.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936361232189747200, '2025-06-21 17:51:08.263157', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361236744761344, '2025-06-21 17:51:09.349863', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*0');
INSERT INTO "public"."device_temp_data" VALUES (1936361241287192576, '2025-06-21 17:51:10.432288', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361245846401024, '2025-06-21 17:51:11.519221', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361250372055040, '2025-06-21 17:51:12.598206', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936361254901903360, '2025-06-21 17:51:13.678376', 194232147738608, '$BDG01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361259540803584, '2025-06-21 17:51:14.784593', 194232147738608, '$GNGGA,095110.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936361264120983552, '2025-06-21 17:51:15.876959', 194232147738608, '$GNGLL,,,,,095110.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936361268688580608, '2025-06-21 17:51:16.965416', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*0,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936361273352646656, '2025-06-21 17:51:18.077154', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361278096404480, '2025-06-21 17:51:19.208689', 194232147738608, '$GNZDA,095110.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361282672390144, '2025-06-21 17:51:20.299855', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361287315484672, '2025-06-21 17:51:21.40621', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361291908247552, '2025-06-21 17:51:22.501774', 194232147738608, '$GNZDA,095117.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936361296912052224, '2025-06-21 17:51:23.694115', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361301525786624, '2025-06-21 17:51:24.794', 194232147738608, '$GNGGA,095118.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936361306114355200, '2025-06-21 17:51:25.888055', 194232147738608, '$GNGLL,,,,,095118.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936361310648397824, '2025-06-21 17:51:26.969624', 194232147738608, '$GNGSA,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936361315287298048, '2025-06-21 17:51:28.075986', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361319854895104, '2025-06-21 17:51:29.1647', 194232147738608, '$GNZDA,095127.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936361324456046592, '2025-06-21 17:51:30.26131', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361329019449344, '2025-06-21 17:51:31.349416', 194232147738608, '$GNGGA,095128.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936361333566074880, '2025-06-21 17:51:32.433084', 194232147738608, '$GNGLL,,,,,095128.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361338213363712, '2025-06-21 17:51:33.541511', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361342726434816, '2025-06-21 17:51:34.6178', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.E');
INSERT INTO "public"."device_temp_data" VALUES (1936361347294031872, '2025-06-21 17:51:35.706208', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361351861628928, '2025-06-21 17:51:36.795717', 194232147738608, '$GNGGA,095130.000,,,,*42');
INSERT INTO "public"."device_temp_data" VALUES (1936361356391477248, '2025-06-21 17:51:37.875303', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361360950685696, '2025-06-21 17:51:38.962148', 194232147738608, '$GNGGA,095135.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936361365564420096, '2025-06-21 17:51:40.062513', 194232147738608, '$GNGLL,,,,,095135.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936361370849243136, '2025-06-21 17:51:41.32215', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361375458783232, '2025-06-21 17:51:42.421892', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361379967660032, '2025-06-21 17:51:43.496781', 194232147738608, '$GPGSV,1,1,01,32,,,25,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936361384522674176, '2025-06-21 17:51:44.582709', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361389048328192, '2025-06-21 17:51:45.661553', 194232147738608, '$GNRMC,095138.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936361393599148032, '2025-06-21 17:51:46.746678', 194232147738608, '$GNVTG,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936361409000632320, '2025-06-21 17:51:50.418697', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361413505314816, '2025-06-21 17:51:51.492504', 194232147738608, '$GNGGA,095143.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936361418035163136, '2025-06-21 17:51:52.57219', 194232147738608, '$GNGLL,,,,,095143.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936361422606954496, '2025-06-21 17:51:53.662348', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361427170357248, '2025-06-21 17:51:54.750778', 194232147738608, '0,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936361431771508736, '2025-06-21 17:51:55.847174', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361436339105792, '2025-06-21 17:51:56.936612', 194232147738608, '$GNGGA,095154.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936361440856371200, '2025-06-21 17:51:58.013321', 194232147738608, '$GNGLL,,,,,095154.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936361445377830912, '2025-06-21 17:51:59.091139', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361449928650752, '2025-06-21 17:52:00.176108', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361454529802240, '2025-06-21 17:52:01.273527', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361459101593600, '2025-06-21 17:52:02.363806', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361463614664704, '2025-06-21 17:52:03.439648', 194232147738608, '$GNRMC,095157.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936361468161290240, '2025-06-21 17:52:04.523739', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361473005711360, '2025-06-21 17:52:05.678842', 194232147738608, '$GNZD210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936361477736886272, '2025-06-21 17:52:06.806441', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361482874908672, '2025-06-21 17:52:08.03149', 194232147738608, '$GNZDA,095202.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361487425728512, '2025-06-21 17:52:09.116214', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361492026880000, '2025-06-21 17:52:10.213066', 194232147738608, '$GNGGA,095203.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936361496628031488, '2025-06-21 17:52:11.310897', 194232147738608, '$GNGLL,,,,,095203.000,V,N*6ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361501170462720, '2025-06-21 17:52:12.393814', 194232147738608, '$GNGGA,095210.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936361505700311040, '2025-06-21 17:52:13.473965', 194232147738608, '$GNGLL,,,,,095210.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936361510238547968, '2025-06-21 17:52:14.555859', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361514768396288, '2025-06-21 17:52:15.635447', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361519319216128, '2025-06-21 17:52:16.720315', 194232147738608, '$GPGSV,1,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936361523861647360, '2025-06-21 17:52:17.803491', 194232147738608, '$GNGGA,095212.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936361528437633024, '2025-06-21 17:52:18.894529', 194232147738608, '$GNGLL,,,,,095212.000,V,N00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936361533001035776, '2025-06-21 17:52:19.982203', 194232147738608, '$GNGLL,,,,,095217.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936361537656713216, '2025-06-21 17:52:21.092122', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361542178172928, '2025-06-21 17:52:22.170583', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361546728992768, '2025-06-21 17:52:23.255961', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361551288201216, '2025-06-21 17:52:24.342529', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361555889352704, '2025-06-21 17:52:25.439098', 194232147738608, '$GNRMC01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361560423395328, '2025-06-21 17:52:26.520102', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361564953243648, '2025-06-21 17:52:27.600205', 194232147738608, '$GNRMC,095219.000,V,,,,,,,210,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361569495674880, '2025-06-21 17:52:28.683677', 194232147738608, '$GNGGA,095228.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936361574092632064, '2025-06-21 17:52:29.779583', 194232147738608, '$GNGLL,,,,,095228.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936361578664423424, '2025-06-21 17:52:30.86916', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361583181688832, '2025-06-21 17:52:31.94699', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361587677982720, '2025-06-21 17:52:33.01813', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361592258162688, '2025-06-21 17:52:34.1104', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361596829954048, '2025-06-21 17:52:35.200316', 194232147738608, '$GNRMC,095228.000,V,,,,,,,210625,,,N,V*2F');
INSERT INTO "public"."device_temp_data" VALUES (1936361601347219456, '2025-06-21 17:52:36.277903', 194232147738608, '$GNVTG,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936361605906427904, '2025-06-21 17:52:37.364922', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361611312885760, '2025-06-21 17:52:38.653944', 194232147738608, '$GNGGA,095236.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936361615867899904, '2025-06-21 17:52:39.739655', 194232147738608, '$GNGLL,,,,,095236.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936361620406136832, '2025-06-21 17:52:40.821061', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361624998899712, '2025-06-21 17:52:41.915064', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361629520359424, '2025-06-21 17:52:42.994155', 194232147738608, '$GPGSV,1,1,01,32,,,24,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936361634058596352, '2025-06-21 17:52:44.076239', 194232147738608, '$B,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936361638601027584, '2025-06-21 17:52:45.159187', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361643143458816, '2025-06-21 17:52:46.242776', 194232147738608, '$GNZDA,095237.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936361647681695744, '2025-06-21 17:52:47.324502', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361652232515584, '2025-06-21 17:52:48.409542', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361656825278464, '2025-06-21 17:52:49.504823', 194232147738608, '$GNZDA,095244.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936361661359321088, '2025-06-21 17:52:50.585614', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361665905946624, '2025-06-21 17:52:51.669299', 194232147738608, '$GNGGA,095245.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936361670452572160, '2025-06-21 17:52:52.753241', 194232147738608, '$GNGLL,,,,,095245NZDA,095250.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936361675032752128, '2025-06-21 17:52:53.845207', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361679579377664, '2025-06-21 17:52:54.929889', 194232147738608, '$GNGGA,095251.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936361684058894336, '2025-06-21 17:52:55.997626', 194232147738608, '$GNGLL,,,,,095251.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936361688609714176, '2025-06-21 17:52:57.0823', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361693126979584, '2025-06-21 17:52:58.159324', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361697656827904, '2025-06-21 17:52:59.239417', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936361702241202176, '2025-06-21 17:53:00.332914', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361706771050496, '2025-06-21 17:53:01.412734', 194232147738608, '$GNZDA,095258.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936361711317676032, '2025-06-21 17:53:02.496636', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361715843330048, '2025-06-21 17:53:03.575499', 194232147738608, '$GNGGA,095259.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936361720364789760, '2025-06-21 17:53:04.653335', 194232147738608, '$GNGLL,,,,,095259.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936361724974329856, '2025-06-21 17:53:05.752419', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936361729520955392, '2025-06-21 17:53:06.83635', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361734046609408, '2025-06-21 17:53:07.915856', 194232147738608, '$GNZDA,095259.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936361738551291904, '2025-06-21 17:53:08.989957', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361743081140224, '2025-06-21 17:53:10.069095', 194232147738608, '$GNGGA,095306.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936361747615182848, '2025-06-21 17:53:11.150679', 194232147738608, '$GNGLL,,,,,095306.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936361752174391296, '2025-06-21 17:53:12.237389', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361756725211136, '2025-06-21 17:53:13.322383', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2564');
INSERT INTO "public"."device_temp_data" VALUES (1936361761250865152, '2025-06-21 17:53:14.401888', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361765772324864, '2025-06-21 17:53:15.479622', 194232147738608, '$GNRMC,095307.000,V,,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936361770314756096, '2025-06-21 17:53:16.562252', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361774869770240, '2025-06-21 17:53:17.648641', 194232147738608, '$GNZDA,095313.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936361779361869824, '2025-06-21 17:53:18.719805', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361783967215616, '2025-06-21 17:53:19.817061', 194232147738608, '$GNGGA,095314.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936361788446732288, '2025-06-21 17:53:20.885759', 194232147738608, '$GNGLL,,,,,095314.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936361792980774912, '2025-06-21 17:53:21.966512', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25E');
INSERT INTO "public"."device_temp_data" VALUES (1936361797506428928, '2025-06-21 17:53:23.045689', 194232147738608, '$GNZDA,095315.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936361802048860160, '2025-06-21 17:53:24.128454', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361806612262912, '2025-06-21 17:53:25.216423', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361811142111232, '2025-06-21 17:53:26.296319', 194232147738608, '$GNZDA,095322.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936361815667765248, '2025-06-21 17:53:27.375901', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361820214390784, '2025-06-21 17:53:28.459521', 194232147738608, '$GNGGA,095323.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936361824765210624, '2025-06-21 17:53:29.544073', 194232147738608, '$GNGLL,,,,,095323.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936361829500579840, '2025-06-21 17:53:30.673243', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2,V,,,,,,,210625,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361834382749696, '2025-06-21 17:53:31.837141', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361838971318272, '2025-06-21 17:53:32.931918', 194232147738608, '$GNZDA,095323.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936361843568275456, '2025-06-21 17:53:34.027365', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361848182009856, '2025-06-21 17:53:35.127927', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361853622022144, '2025-06-21 17:53:36.424179', 194232147738608, '$GNZDA,095330.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361858269310976, '2025-06-21 17:53:37.532148', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361862849490944, '2025-06-21 17:53:38.624634', 194232147738608, '$GNGGA,095331.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936361867450642432, '2025-06-21 17:53:39.721123', 194232147738608, '$GNGLL,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361872068571136, '2025-06-21 17:53:40.822003', 194232147738608, '$GNGSA,A,1,,,,,,,340.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936361876673916928, '2025-06-21 17:53:41.920077', 194232147738608, '$GNGLL,,,,,095340.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936361881308622848, '2025-06-21 17:53:43.025515', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361886006243328, '2025-06-21 17:53:44.145929', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936361890569646080, '2025-06-21 17:53:45.233047', 194232147738608, '$GPGSV,1,1,01,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936361895149826048, '2025-06-21 17:53:46.32516', 194232147738608, '$BDGSV,1,1,01,08,,,21,0*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936361899771949056, '2025-06-21 17:53:47.427661', 194232147738608, '$GNRMC,095340.000,V,,,,,,,2,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936361904385683456, '2025-06-21 17:53:48.527286', 194232147738608, '$GNGLL,,,,,095341.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936361908932308992, '2025-06-21 17:53:49.611705', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361913491517440, '2025-06-21 17:53:50.698253', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5NVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361918088474624, '2025-06-21 17:53:51.794718', 194232147738608, '$GNZDA,095347.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936361922618322944, '2025-06-21 17:53:52.874873', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361927114616832, '2025-06-21 17:53:53.946193', 194232147738608, '$GNGGA,095348.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936361931719962624, '2025-06-21 17:53:55.044694', 194232147738608, '$GNGLL,,,,,095348.,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936361936262393856, '2025-06-21 17:53:56.127249', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361940809019392, '2025-06-21 17:53:57.211941', 194232147738608, '$GNZDA,095355.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936361945464696832, '2025-06-21 17:53:58.321821', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361950086819840, '2025-06-21 17:53:59.423341', 194232147738608, '$GNGGA,095356.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936361954637639680, '2025-06-21 17:54:00.508748', 194232147738608, '$GNGLL,,,,,095356.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936361959192653824, '2025-06-21 17:54:01.594017', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936361963760250880, '2025-06-21 17:54:02.683198', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936361968340430848, '2025-06-21 17:54:03.775061', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361972937388032, '2025-06-21 17:54:04.871035', 194232147738608, '$GNZDA,095358.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936361977479819264, '2025-06-21 17:54:05.954249', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361982068387840, '2025-06-21 17:54:07.0489', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936361986686316544, '2025-06-21 17:54:08.149734', 194232147738608, '$GNZDA,095402.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936361991262302208, '2025-06-21 17:54:09.240074', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936361995787956224, '2025-06-21 17:54:10.319314', 194232147738608, '$GNGGA,095403.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936362000359747584, '2025-06-21 17:54:11.409555', 194232147738608, '$GNGLL,,,,,095,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362005011230720, '2025-06-21 17:54:12.518326', 194232147738608, '$GNGGA,095411.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936362009574633472, '2025-06-21 17:54:13.606737', 194232147738608, '$GNGLL,,,,,095411.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362014100287488, '2025-06-21 17:54:14.685271', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362018596581376, '2025-06-21 17:54:15.757445', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362023185149952, '2025-06-21 17:54:16.851458', 194232147738608, '$GPGSV,1,1,01,32,,,22,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936362027765329920, '2025-06-21 17:54:17.943689', 194232147738608, '$BDGSV,1,1,02TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362032332926976, '2025-06-21 17:54:19.032059', 194232147738608, ',1,1,02,26,,,25,40,,,23,0*70');
INSERT INTO "public"."device_temp_data" VALUES (1936362036850192384, '2025-06-21 17:54:20.109569', 194232147738608, '$GNRMC,095418.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936362041350680576, '2025-06-21 17:54:21.182388', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362045914083328, '2025-06-21 17:54:22.270134', 194232147738608, '$GNZDA,095418.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936362050460708864, '2025-06-21 17:54:23.354959', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362054977974272, '2025-06-21 17:54:24.431972', 194232147738608, '$GNGGA,095419.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936362059528794112, '2025-06-21 17:54:25.516001', 194232147738608, '$GNGLL,,,,,095419.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936362064046059520, '2025-06-21 17:54:26.593161', 194232147738608, '$GNGSA,A,1,,,,,,TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362068584296448, '2025-06-21 17:54:27.675006', 194232147738608, '$GNZDA,095421.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936362073143504896, '2025-06-21 17:54:28.762492', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362077874679808, '2025-06-21 17:54:29.890343', 194232147738608, '$GNGGA$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362082463248384, '2025-06-21 17:54:30.984123', 194232147738608, '$GNZDA,095426.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936362086993096704, '2025-06-21 17:54:32.064961', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362091543916544, '2025-06-21 17:54:33.149173', 194232147738608, '$GNGGA,095427.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936362096149262336, '2025-06-21 17:54:34.24701', 194232147738608, '$GNGLL,,,,,095427.000,V,N*,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362100658139136, '2025-06-21 17:54:35.322696', 194232147738608, '$GNZDA,095432.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936362105204764672, '2025-06-21 17:54:36.406162', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362109734612992, '2025-06-21 17:54:37.486049', 194232147738608, '$GNGGA,095433.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936362114243489792, '2025-06-21 17:54:38.561247', 194232147738608, '$GNGLL,,,,,095433.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362118769143808, '2025-06-21 17:54:39.640232', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5DA,095434.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936362123328352256, '2025-06-21 17:54:40.727101', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362127954669568, '2025-06-21 17:54:41.83082', 194232147738608, 'E');
INSERT INTO "public"."device_temp_data" VALUES (1936362132601958400, '2025-06-21 17:54:42.938776', 194232147738608, '$GNZDA,095439.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936362137161166848, '2025-06-21 17:54:44.025685', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362141787484160, '2025-06-21 17:54:45.128628', 194232147738608, '$GNGGA,095440.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936362146325721088, '2025-06-21 17:54:46.210041', 194232147738608, '$GNGLL,,,,,095440.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936362150918483968, '2025-06-21 17:54:47.305713', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*015.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936362155486081024, '2025-06-21 17:54:48.394816', 194232147738608, '$GNGLL,,,,,095441.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936362160049483776, '2025-06-21 17:54:49.482055', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362164570943488, '2025-06-21 17:54:50.560525', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362169075625984, '2025-06-21 17:54:51.634119', 194232147738608, '$GNGGA,095450.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936362174373031936, '2025-06-21 17:54:52.897797', 194232147738608, '$GNGLL,,,,,095450.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936362178894491648, '2025-06-21 17:54:53.975045', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362183378202624, '2025-06-21 17:54:55.044033', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362187895468032, '2025-06-21 17:54:56.121436', 194232147738608, '$GPGSV,1,1,01,32,,,21,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936362192429510656, '2025-06-21 17:54:57.202785', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362196955164672, '2025-06-21 17:54:58.281391', 194232147738608, '$GNRMC,095450.000,V,,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936362201543733248, '2025-06-21 17:54:59.375977', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362206081970176, '2025-06-21 17:55:00.45711', 194232147738608, '$GNZDA,095450.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936362210578264064, '2025-06-21 17:55:01.529736', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362215087140864, '2025-06-21 17:55:02.604313', 194232147738608, '00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936362219591823360, '2025-06-21 17:55:03.678801', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362224125865984, '2025-06-21 17:55:04.759948', 194232147738608, '$GNGGA,095459.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936362228622159872, '2025-06-21 17:55:05.831284', 194232147738608, '$GNGLL,,,,,095459.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936362233202339840, '2025-06-21 17:55:06.923231', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362237719605248, '2025-06-21 17:55:08.000623', 194232147738608, '$GNZDA,095503.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936362242232676352, '2025-06-21 17:55:09.076564', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362246783496192, '2025-06-21 17:55:10.161832', 194232147738608, '$GNGGA,095504.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936362251317538816, '2025-06-21 17:55:11.242505', 194232147738608, '$GNGLL,,,,,095504.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936362255910301696, '2025-06-21 17:55:12.337958', 194232147738608, '$GNGSA,A,1,,,,095507.000,V,,,,,,,210625,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362273098559488, '2025-06-21 17:55:16.435126', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362277582270464, '2025-06-21 17:55:17.50418', 194232147738608, '$GNZDA,095507.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936362282615435264, '2025-06-21 17:55:18.704561', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362287711514624, '2025-06-21 17:55:19.919389', 194232147738608, '$GNGGA,095514.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936362292237168640, '2025-06-21 17:55:20.998072', 194232147738608, '$GNGLL,,,,,095514.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936362296779599872, '2025-06-21 17:55:22.081811', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362301351391232, '2025-06-21 17:55:23.171544', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362305856073728, '2025-06-21 17:55:24.245987', 194232147738608, '$GPGSV,1,1,010,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936362310520139776, '2025-06-21 17:55:25.357935', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362315033210880, '2025-06-21 17:55:26.43383', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362319592419328, '2025-06-21 17:55:27.520953', 194232147738608, '$GNZDA,095524.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936362324113879040, '2025-06-21 17:55:28.598903', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362328618561536, '2025-06-21 17:55:29.672328', 194232147738608, '$GNGGA,095525.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362333165187072, '2025-06-21 17:55:30.756347', 194232147738608, '$GNGLL,,,,,095525.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936362337711812608, '2025-06-21 17:55:31.840314', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362342312964096, '2025-06-21 17:55:32.937925', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362346834423808, '2025-06-21 17:55:34.015969', 194232147738608, '$GNZDA,095525.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936362351573987328, '2025-06-21 17:55:35.145105', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362356099641344, '2025-06-21 17:55:36.224715', 194232147738608, '1,32,,,21,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936362361363492864, '2025-06-21 17:55:37.479884', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362366124027904, '2025-06-21 17:55:38.614117', 194232147738608, '$GNRMC,095533.000,V,,,,,,,210625,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936362370720985088, '2025-06-21 17:55:39.710886', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362386487373824, '2025-06-21 17:55:43.469037', 194232147738608, '$GNZDA,095533.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936362391000444928, '2025-06-21 17:55:44.545886', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362395559653376, '2025-06-21 17:55:45.63258', 194232147738608, '$GNZDA,095534.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936362400072724480, '2025-06-21 17:55:46.70899', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362404610961408, '2025-06-21 17:55:47.790765', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362409161781248, '2025-06-21 17:55:48.875423', 194232147738608, '$GNZDA,095544.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936362413670658048, '2025-06-21 17:55:49.950023', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362418183729152, '2025-06-21 17:55:51.026934', 194232147738608, '$GNGGA,095545.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936362422755520512, '2025-06-21 17:55:52.116722', 194232147738608, '$GNGLL,,,,,095545.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362427339894784, '2025-06-21 17:55:53.209519', 194232147738608, '$GNGSA,A,1,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362431865548800, '2025-06-21 17:55:54.288842', 194232147738608, '$GNGGA,095546.000,,,,,0,00,25.5,,,,,,N*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362436391202816, '2025-06-21 17:55:55.367565', 194232147738608, '$GNGGA,095554.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936362441218846720, '2025-06-21 17:55:56.518148', 194232147738608, '$GNGLL,,,,,095554.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362445807415296, '2025-06-21 17:55:57.612978', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362450328875008, '2025-06-21 17:55:58.69023', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362454867111936, '2025-06-21 17:55:59.772705', 194232147738608, '$GPGSV,1,1,01,32,,,20,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936362459434708992, '2025-06-21 17:56:00.861324', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362463989723136, '2025-06-21 17:56:01.94725', 194232147738608, '$GNRMC');
INSERT INTO "public"."device_temp_data" VALUES (1936362468582486016, '2025-06-21 17:56:03.042361', 194232147738608, '$GNGGA,095555.000,,,,,0,00,25.5,,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362474160910336, '2025-06-21 17:56:04.372562', 194232147738608, '$GNRMC,095602.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936362478678175744, '2025-06-21 17:56:05.449883', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362483753283584, '2025-06-21 17:56:06.659877', 194232147738608, '$GNZDA,095602.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936362488337657856, '2025-06-21 17:56:07.752114', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362492859117568, '2025-06-21 17:56:08.830857', 194232147738608, '$GNGGA,095603.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936362497372188672, '2025-06-21 17:56:09.906398', 194232147738608, '$GNGLL,,,,,095603.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936362501876871168, '2025-06-21 17:56:10.980739', 194232147738608, '$GNGSA,A,1,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362506423496704, '2025-06-21 17:56:12.064134', 194232147738608, '$GNGGA,095604.000,,,,,0,00,25.5,,4');
INSERT INTO "public"."device_temp_data" VALUES (1936362510961733632, '2025-06-21 17:56:13.146875', 194232147738608, '$GNRMC,095611.000,V,,,,,,,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936362515525136384, '2025-06-21 17:56:14.234441', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362520101122048, '2025-06-21 17:56:15.325829', 194232147738608, '$GNZDA,095611.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936362524630970368, '2025-06-21 17:56:16.405774', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362529253093376, '2025-06-21 17:56:17.507905', 194232147738608, '$GNGGA,095612.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936362533887799296, '2025-06-21 17:56:18.612019', 194232147738608, '$GNGLL,,,,,095612.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936362538539282432, '2025-06-21 17:56:19.721335', 194232147738608, '$GNGSA,A,1,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362543127851008, '2025-06-21 17:56:20.815601', 194232147738608, '$GNGGA,095613.000,,,,,0,00,25.5,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936362547687059456, '2025-06-21 17:56:21.902767', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362552355319808, '2025-06-21 17:56:23.015436', 194232147738608, '$GNGGA,095620.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936362556922916864, '2025-06-21 17:56:24.10442', 194232147738608, '$GNGLL,,,,,095620.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362562648141824, '2025-06-21 17:56:25.469196', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362567236710400, '2025-06-21 17:56:26.563551', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362571770753024, '2025-06-21 17:56:27.64463', 194232147738608, '$GPGSV,1,1,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362576279629824, '2025-06-21 17:56:28.71905', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*040,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936362581010804736, '2025-06-21 17:56:29.847415', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362586153021440, '2025-06-21 17:56:31.073883', 194232147738608, '$GNGGA,095628.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936362591072940032, '2025-06-21 17:56:32.246212', 194232147738608, '$GNGLL,,,,,095628.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936362595644731392, '2025-06-21 17:56:33.336574', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362600241688576, '2025-06-21 17:56:34.432797', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362604800897024, '2025-06-21 17:56:35.5195', 194232147738608, '$GPGSV,1,1,01,32,,,18,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362609381076992, '2025-06-21 17:56:36.611132', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362613978034176, '2025-06-21 17:56:37.707092', 194232147738608, '$GNRMC,095631.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936362618478522368, '2025-06-21 17:56:38.780852', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362623062896640, '2025-06-21 17:56:39.873108', 194232147738608, '$GNZDA,095634.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936362627613716480, '2025-06-21 17:56:40.958909', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362632281976832, '2025-06-21 17:56:42.071909', 194232147738608, '$GNGGA,095635.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936362636878934016, '2025-06-21 17:56:43.167713', 194232147738608, '$GNGLL,,,,,095635.000,V,N*1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362641400393728, '2025-06-21 17:56:44.245942', 194232147738608, '$GNRMC,095641.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936362645959602176, '2025-06-21 17:56:45.332491', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362650493644800, '2025-06-21 17:56:46.413938', 194232147738608, '$GNZDA,095641.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936362655031881728, '2025-06-21 17:56:47.495703', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362659603673088, '2025-06-21 17:56:48.585569', 194232147738608, '$GNGGA,095642.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936362668785004544, '2025-06-21 17:56:50.774217', 194232147738608, '$GNGGA,095644.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936362673306464256, '2025-06-21 17:56:51.852888', 194232147738608, '$GNGLL,,,,,095644.000,V,5649.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936362677886644224, '2025-06-21 17:56:52.944772', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362682483601408, '2025-06-21 17:56:54.040203', 194232147738608, '$GNGGA,095650.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936362687042809856, '2025-06-21 17:56:55.127099', 194232147738608, '$GNGLL,,,,,095650.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936362691732041728, '2025-06-21 17:56:56.245975', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362696278667264, '2025-06-21 17:56:57.329652', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362700863041536, '2025-06-21 17:56:58.422393', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362705346752512, '2025-06-21 17:56:59.491881', 194232147738608, '$GPGSV,1,1,01,32,,,19,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936362709968875520, '2025-06-21 17:57:00.592632', 194232147738608, '$BDGSV,1,1,00,0,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936362724271452160, '2025-06-21 17:57:04.00358', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362729459806208, '2025-06-21 17:57:05.240733', 194232147738608, '$GNGGA,095658.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936362755737120768, '2025-06-21 17:57:11.505832', 194232147738608, '$GNGLL,,,,,095658.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936362760279552000, '2025-06-21 17:57:12.588897', 194232147738608, '$GNGSA,A,1,,');
INSERT INTO "public"."device_temp_data" VALUES (1936362764884897792, '2025-06-21 17:57:13.686489', 194232147738608, '$GNGGA,095659.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936362769460883456, '2025-06-21 17:57:14.777309', 194232147738608, '$GNGLL,,,,,095659.00210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936362774447910912, '2025-06-21 17:57:15.966201', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362782115098624, '2025-06-21 17:57:17.794731', 194232147738608, '$GNZDA,095712.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936362786682695680, '2025-06-21 17:57:18.883975', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362792412114944, '2025-06-21 17:57:20.249945', 194232147738608, '$GNGGA,095713.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936362796941963264, '2025-06-21 17:57:21.329805', 194232147738608, '$GNGLL,,,,,095713.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936362801496977408, '2025-06-21 17:57:22.415508', 194232147738608, '$GNGSA,A,1,,,$GNGLL,,,,,095715.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936362806098128896, '2025-06-21 17:57:23.512497', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362811361980416, '2025-06-21 17:57:24.767535', 194232147738608, '$G21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936362816462254080, '2025-06-21 17:57:25.983472', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362820966936576, '2025-06-21 17:57:27.057798', 194232147738608, '$GNGGA,095723.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936362825928798208, '2025-06-21 17:57:28.240092', 194232147738608, '$GNGLL,,,,,095723.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936362830534144000, '2025-06-21 17:57:29.338261', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362835093352448, '2025-06-21 17:57:30.425102', 194232147738608, '$GNGSA,A,1,G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362839723864064, '2025-06-21 17:57:31.529282', 194232147738608, '$GNZDA,095723.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936362844383735808, '2025-06-21 17:57:32.640987', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362848968110080, '2025-06-21 17:57:33.733819', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362853514735616, '2025-06-21 17:57:34.817551', 194232147738608, '$GNZDA,095730.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936362858078138368, '2025-06-21 17:57:35.905863', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362862649929728, '2025-06-21 17:57:36.995594', 194232147738608, '$GNGGA,095731.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936362867154612224, '2025-06-21 17:57:38.069639', 194232147738608, '$GNGLL,,,,,095731.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936362872774979584, '2025-06-21 17:57:39.409296', 194232147738608, '$GNGSA,A,1,TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362877392908288, '2025-06-21 17:57:40.51079', 194232147738608, '$GNZDA,095732.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936362883613061120, '2025-06-21 17:57:41.99304', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362888142909440, '2025-06-21 17:57:43.073576', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362892731478016, '2025-06-21 17:57:44.167506', 194232147738608, '$GNZDA,095739.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936362897328435200, '2025-06-21 17:57:45.263309', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362901883449344, '2025-06-21 17:57:46.349628', 194232147738608, '$GNGGA,095740.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936362907059220480, '2025-06-21 17:57:47.583964', 194232147738608, '$GNGLL,,,,,095740.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936362911651983360, '2025-06-21 17:57:48.678611', 194232147738608, '$GNGSA,A,1025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936362916202803200, '2025-06-21 17:57:49.763228', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362920741040128, '2025-06-21 17:57:50.845886', 194232147738608, '$GNGGA,095749.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936362925275082752, '2025-06-21 17:57:51.926823', 194232147738608, '$GNGLL,,,,,095749.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936362929796542464, '2025-06-21 17:57:53.004865', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362934393499648, '2025-06-21 17:57:54.10092', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936362938927542272, '2025-06-21 17:57:55.181886', 194232147738608, '$GPGSV,1,1,01,32,,,18,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362943507722240, '2025-06-21 17:57:56.273364', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362948696076288, '2025-06-21 17:57:57.510906', 194232147738608, '$GNRMC,0,32,,,18,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936362953276256256, '2025-06-21 17:57:58.602142', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936362957835464704, '2025-06-21 17:57:59.689033', 194232147738608, '$GNRMC,095751.00*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936362962667302912, '2025-06-21 17:58:00.84129', 194232147738608, '$GNZDA,095758.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936362967348146176, '2025-06-21 17:58:01.957197', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362976315568128, '2025-06-21 17:58:04.095722', 194232147738608, '$GNGGA,095759.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936362980874776576, '2025-06-21 17:58:05.182883', 194232147738608, '$GNGLL,,,,,095759.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936362985601757184, '2025-06-21 17:58:06.309156', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936362990290989056, '2025-06-21 17:58:07.427971', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5759.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936362995143798784, '2025-06-21 17:58:08.584332', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936362999665258496, '2025-06-21 17:58:09.662437', 194232147738608, '$GNGGA,095800.000,,,,,0,00,25.5,,,OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363004656480256, '2025-06-21 17:58:10.85291', 194232147738608, '$GNGGA,095808.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936363009408626688, '2025-06-21 17:58:11.98585', 194232147738608, '$GNGLL,,,,,095808.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936363013967835136, '2025-06-21 17:58:13.072211', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363019592396800, '2025-06-21 17:58:14.413727', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363024789139456, '2025-06-21 17:58:15.652326', 194232147738608, '$GPGSV,1,1,01,32,A,095810.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936363030858297344, '2025-06-21 17:58:17.099654', 194232147738608, '$GNGLL,,,,,095810.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936363035430088704, '2025-06-21 17:58:18.189942', 194232147738608, '$GNGSA,A,1,,,,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936363040094154752, '2025-06-21 17:58:19.301968', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363044636585984, '2025-06-21 17:58:20.384632', 194232147738608, '$GNGGA,095816.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936363049149657088, '2025-06-21 17:58:21.46009', 194232147738608, '$GNGLL,,,,,095816.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936363053645950976, '2025-06-21 17:58:22.532802', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363058159022080, '2025-06-21 17:58:23.608825', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363062726619136, '2025-06-21 17:58:24.697195', 194232147738608, '$GNZDA,095819.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936363067298410496, '2025-06-21 17:58:25.787835', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363071819870208, '2025-06-21 17:58:26.86527', 194232147738608, '$GNGGA,095820.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936363076374884352, '2025-06-21 17:58:27.951896', 194232147738608, ',00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936363080913121280, '2025-06-21 17:58:29.033535', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363085451358208, '2025-06-21 17:58:30.115886', 194232147738608, '$GNGGA,095824.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936363089993789440, '2025-06-21 17:58:31.198597', 194232147738608, '$GNGLL,,,,,095824.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936363094469111808, '2025-06-21 17:58:32.265256', 194232147738608, '$GNGSA,A,1,,,,,0,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936363099007348736, '2025-06-21 17:58:33.347809', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363103524614144, '2025-06-21 17:58:34.42457', 194232147738608, '$GNGGA,095830.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936363108054462464, '2025-06-21 17:58:35.504738', 194232147738608, '$GNGLL,,,,,095830.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936363112554950656, '2025-06-21 17:58:36.577303', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363117114159104, '2025-06-21 17:58:37.664814', 194232147738608, '$GNGSA,A,1,,');
INSERT INTO "public"."device_temp_data" VALUES (1936363121610452992, '2025-06-21 17:58:38.736337', 194232147738608, '$GNGGA,095833.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936363126136107008, '2025-06-21 17:58:39.815541', 194232147738608, '$GNGLL,,,,,095833.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936363130779201536, '2025-06-21 17:58:40.922364', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363135900446720, '2025-06-21 17:58:42.143466', 194232147738608, '$GNZDA,095837.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936363140434489344, '2025-06-21 17:58:43.224', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363145476042752, '2025-06-21 17:58:44.426304', 194232147738608, '$GNGGA,095838.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936363151062855680, '2025-06-21 17:58:45.758468', 194232147738608, '$GNGLL,,,,,095838.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936363156502867968, '2025-06-21 17:58:47.055107', 194232147738608, '$GNGSA,A,1,,,,095841.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936363161087242240, '2025-06-21 17:58:48.148343', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363165663227904, '2025-06-21 17:58:49.239899', 194232147738608, '$GNZDA,095841.000,21,06,20,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363170201464832, '2025-06-21 17:58:50.321165', 194232147738608, '$GNZDA,095847.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363174727118848, '2025-06-21 17:58:51.400933', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363179332464640, '2025-06-21 17:58:52.49827', 194232147738608, '$GNGGA,095848.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936363183832952832, '2025-06-21 17:58:53.571065', 194232147738608, '$GNGLL,,,,,095848.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936363188387966976, '2025-06-21 17:58:54.657925', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363192913620992, '2025-06-21 17:58:55.736486', 194232147738608, '$GNZDA,095849.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936363198315884544, '2025-06-21 17:58:57.024222', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363202996727808, '2025-06-21 17:58:58.140607', 194232147738608, '56.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936363208545792000, '2025-06-21 17:58:59.463318', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363213084028928, '2025-06-21 17:59:00.545078', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363274257952768, '2025-06-21 17:59:15.130757', 194232147738608, '$GNRMC,095856.000,V,,,,,,,2');
INSERT INTO "public"."device_temp_data" VALUES (1936363278745858048, '2025-06-21 17:59:16.200167', 194232147738608, '$GNZDA,095857.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936363283279900672, '2025-06-21 17:59:17.281935', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363302816968704, '2025-06-21 17:59:21.939471', 194232147738608, '$GNGGA,095914.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936363319652904960, '2025-06-21 17:59:25.953653', 194232147738608, '$GNGLL,,,,,095914.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936363326649004032, '2025-06-21 17:59:27.621456', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363331237572608, '2025-06-21 17:59:28.715557', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363335784198144, '2025-06-21 17:59:29.799788', 194232147738608, '$GPGSV,1,15,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936363340397932544, '2025-06-21 17:59:30.899449', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363344898420736, '2025-06-21 17:59:31.972202', 194232147738608, '$GNGGA,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363349411491840, '2025-06-21 17:59:33.04811', 194232147738608, '$GPGSV,1,1,01,32,,,13,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936363354079752192, '2025-06-21 17:59:34.161346', 194232147738608, '$BDGSV,1,1,01,12,,,24,0*70');
INSERT INTO "public"."device_temp_data" VALUES (1936363358605406208, '2025-06-21 17:59:35.240774', 194232147738608, '$GNRMC,095931.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936363363185586176, '2025-06-21 17:59:36.332007', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363367698657280, '2025-06-21 17:59:37.408985', 194232147738608, '$GNZDA,095931.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363372736016384, '2025-06-21 17:59:38.609465', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363377244893184, '2025-06-21 17:59:39.684277', 194232147738608, '$GNGGA,095932.000,,,,,0,00,25.5,,,,,,00,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936363393489432576, '2025-06-21 17:59:43.557235', 194232147738608, '$XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363398006697984, '2025-06-21 17:59:44.634859', 194232147738608, '$GNGGA,095940.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936363402544934912, '2025-06-21 17:59:45.716244', 194232147738608, '$GNGLL,,,,,095940.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936363412976168960, '2025-06-21 17:59:48.20302', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363417455685632, '2025-06-21 17:59:49.271217', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363422014894080, '2025-06-21 17:59:50.358696', 194232147738608, '$GPGSV,1,1,01,32,,,10,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936363426532159488, '2025-06-21 17:59:51.435177', 194232147738608, '$BDGSV,1,1,01,28,,,*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363441715539968, '2025-06-21 17:59:55.055133', 194232147738608, '$GNGGA,095945.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936363446270554112, '2025-06-21 17:59:56.141224', 194232147738608, '$GNGLL,,,,,095945.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936363450854928384, '2025-06-21 17:59:57.234041', 194232147738608, '$GNGSA,A,1,,,,,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363455426719744, '2025-06-21 17:59:58.324366', 194232147738608, '$GNGGA,095952.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936363460011094016, '2025-06-21 17:59:59.417704', 194232147738608, '$GNGLL,,,,,095952.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936363464616439808, '2025-06-21 18:00:00.515215', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363469142093824, '2025-06-21 18:00:01.594219', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936363473667747840, '2025-06-21 18:00:02.673328', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363478226956288, '2025-06-21 18:00:03.760816', 194232147738608, '$GNZDA,095957.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363482802941952, '2025-06-21 18:00:04.851074', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363487357956096, '2025-06-21 18:00:05.937504', 194232147738608, '210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936363491858444288, '2025-06-21 18:00:07.010828', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363508887318528, '2025-06-21 18:00:11.070578', 194232147738608, '$GNZDA,100001.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936363513408778240, '2025-06-21 18:00:12.148565', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363535818944512, '2025-06-21 18:00:17.491762', 194232147738608, '$GNGGA,100002.000,,,,,0,00,251,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363552919121920, '2025-06-21 18:00:21.56843', 194232147738608, '$GNGGA,100013.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936363557474136064, '2025-06-21 18:00:22.65437', 194232147738608, '$GNGLL,,,,,100013.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936363562008178688, '2025-06-21 18:00:23.735904', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363566496083968, '2025-06-21 18:00:24.805915', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363571122401280, '2025-06-21 18:00:25.908533', 194232147738608, '$GPGSV,1,1,01,32,,,11,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936363575710969856, '2025-06-21 18:00:27.002135', 194232147738608, '$BDGSV,1,1,00,0*74OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363580286955520, '2025-06-21 18:00:28.093386', 194232147738608, '$GNGGA,100014.000,,,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363584850358272, '2025-06-21 18:00:29.181449', 194232147738608, '$GNGGA,100028.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936363589384400896, '2025-06-21 18:00:30.262182', 194232147738608, '$GNGLL,,,,,100028.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936363593977163776, '2025-06-21 18:00:31.357612', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363598507012096, '2025-06-21 18:00:32.437853', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363603024277504, '2025-06-21 18:00:33.514201', 194232147738608, '$GPGSV,1,1,01,32,,,11,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936363607612846080, '2025-06-21 18:00:34.608311', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936363612130111488, '2025-06-21 18:00:35.685481', 194232147738608, '$GNRMC');
INSERT INTO "public"."device_temp_data" VALUES (1936363616664154112, '2025-06-21 18:00:36.766519', 194232147738608, '$GNGGA,100029.000ZDA,100035.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363621214973952, '2025-06-21 18:00:37.851663', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363625790959616, '2025-06-21 18:00:38.941578', 194232147738608, '$GNGGA,100036.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936363630379528192, '2025-06-21 18:00:40.036772', 194232147738608, '$GNGLL,,,,,100036.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936363635051982848, '2025-06-21 18:00:41.150105', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363639678300160, '2025-06-21 18:00:42.253248', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363644224925696, '2025-06-21 18:00:43.337963', 194232147738608, '$GPGSV,1,1,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363648737996800, '2025-06-21 18:00:44.412591', 194232147738608, '$GN,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936363653242679296, '2025-06-21 18:00:45.487713', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363657806082048, '2025-06-21 18:00:46.575838', 194232147738608, '$GNZDA,100043.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936363662356901888, '2025-06-21 18:00:47.660184', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363667067105280, '2025-06-21 18:00:48.783085', 194232147738608, '$GNGGA,100044.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936363671601147904, '2025-06-21 18:00:49.864722', 194232147738608, '$GNGLL,,,,,100044.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936363676130996224, '2025-06-21 18:00:50.944783', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363680686010368, '2025-06-21 18:00:52.030715', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936363685169721344, '2025-06-21 18:00:53.099252', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363689783455744, '2025-06-21 18:00:54.199427', 194232147738608, '$GNZDA,100047.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936363694317498368, '2025-06-21 18:00:55.280936', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363698843152384, '2025-06-21 18:00:56.359681', 194232147738608, '$GNGGA,100$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363703385583616, '2025-06-21 18:00:57.442483', 194232147738608, '$GNGGA,100053.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936363707915431936, '2025-06-21 18:00:58.52286', 194232147738608, '$GNGLL,,,,,100053.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936363712537554944, '2025-06-21 18:00:59.624521', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936363717130317824, '2025-06-21 18:01:00.719455', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363721710497792, '2025-06-21 18:01:01.811126', 194232147738608, '$GNZDA,100056.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936363726278094848, '2025-06-21 18:01:02.900414', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363730820526080, '2025-06-21 18:01:03.983015', 194232147738608, '$GNGGA,100057.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936363735375540224, '2025-06-21 18:01:05.06903', 194232147738608, ',,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363739888611328, '2025-06-21 18:01:06.145075', 194232147738608, '$GNZDA,100059.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936363744443625472, '2025-06-21 18:01:07.23178', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363748973473792, '2025-06-21 18:01:08.311541', 194232147738608, '$GNGGA,1001000*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363753960501248, '2025-06-21 18:01:09.500443', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363758599401472, '2025-06-21 18:01:10.606496', 194232147738608, '$GNGGA,100108.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936363763259273216, '2025-06-21 18:01:11.717287', 194232147738608, '$GNGLL,,,,,100108.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936363767982059520, '2025-06-21 18:01:12.843708', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363772763566080, '2025-06-21 18:01:13.983365', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363777297608704, '2025-06-21 18:01:15.064482', 194232147738608, '$GPGSV,1,1,02,32,,,11,193,,,21,0*5E');
INSERT INTO "public"."device_temp_data" VALUES (1936363781852622848, '2025-06-21 18:01:16.150946', 194232147738608, '$BDGSV,11,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363786424414208, '2025-06-21 18:01:17.240463', 194232147738608, '2C');
INSERT INTO "public"."device_temp_data" VALUES (1936363791012982784, '2025-06-21 18:01:18.334258', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363795614134272, '2025-06-21 18:01:19.431059', 194232147738608, '$GNZDA,100116.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936363800160759808, '2025-06-21 18:01:20.515143', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363804736745472, '2025-06-21 18:01:21.606257', 194232147738608, '$GNGGA,100117.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936363809245622272, '2025-06-21 18:01:22.681338', 194232147738608, '$GNGLL,,,,,100117.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936363813867745280, '2025-06-21 18:01:23.783243', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363818523422720, '2025-06-21 18:01:24.893175', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,2500120.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936363823162322944, '2025-06-21 18:01:25.999359', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363827713142784, '2025-06-21 18:01:27.084941', 194232147738608, '$GNGGA,100121.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936363832293322752, '2025-06-21 18:01:28.176086', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363840992309248, '2025-06-21 18:01:30.25095', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363845572489216, '2025-06-21 18:01:31.342636', 194232147738608, '$GPGSV,1,1,01,32,,,10,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936363850114920448, '2025-06-21 18:01:32.425736', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936363854690906112, '2025-06-21 18:01:33.516708', 194232147738608, '$GNRMC,100125.000,V,,,,,,,201,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363859329806336, '2025-06-21 18:01:34.622188', 194232147738608, '$GNGGA,100134.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936363864191004672, '2025-06-21 18:01:35.781337', 194232147738608, '$GNGLL,,,,,100134.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936363868850876416, '2025-06-21 18:01:36.892633', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363873636577280, '2025-06-21 18:01:38.033638', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363878380335104, '2025-06-21 18:01:39.16461', 194232147738608, '$GPGSV,1,1,01,32,,,10,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936363883040206848, '2025-06-21 18:01:40.275206', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936363888027234304, '2025-06-21 18:01:41.464247', 194232147738608, '$GNRMC,100134.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936363896793329664, '2025-06-21 18:01:43.554574', 194232147738608, '$GNVTG,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936363901339955200, '2025-06-21 18:01:44.638287', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363905882386432, '2025-06-21 18:01:45.721837', 194232147738608, '$GNGGA,100142.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936363910408040448, '2025-06-21 18:01:46.800382', 194232147738608, '$GNGLL,,,,,100142.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936363914963054592, '2025-06-21 18:01:47.886004', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363919534845952, '2025-06-21 18:01:48.976113', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363924085665792, '2025-06-21 18:01:50.061717', 194232147738608, '$GPGSV,1,1,01,32,,,10,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936363928619708416, '2025-06-21 18:01:51.142554', 194232147738608, 'NZDA,100144.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936363933187305472, '2025-06-21 18:01:52.231509', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363937805234176, '2025-06-21 18:01:53.332547', 194232147738608, 'GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363942343471104, '2025-06-21 18:01:54.41493', 194232147738608, '$GNGGA,100151.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936363946940428288, '2025-06-21 18:01:55.510087', 194232147738608, '$GNGLL,,,,,100151.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936363952061673472, '2025-06-21 18:01:56.731371', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936363956671213568, '2025-06-21 18:01:57.830558', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,00153.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936363961196867584, '2025-06-21 18:01:58.909263', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936363965747687424, '2025-06-21 18:01:59.994702', 194232147738608, '$GNZDA,100153.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936363970302701568, '2025-06-21 18:02:01.080683', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363974861910016, '2025-06-21 18:02:02.167737', 194232147738608, '5.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936363979412729856, '2025-06-21 18:02:03.252895', 194232147738608, '$GPGSV,1,1,01,32,,,09,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936363983980326912, '2025-06-21 18:02:04.341362', 194232147738608, '$BDGSV,1,1,01,33,,,24,0*73');
INSERT INTO "public"."device_temp_data" VALUES (1936363988581478400, '2025-06-21 18:02:05.438193', 194232147738608, '$GNRMC,100158.000,V,,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936363993144881152, '2025-06-21 18:02:06.526532', 194232147738608, '$GNVTG,,,1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936363997687312384, '2025-06-21 18:02:07.609358', 194232147738608, '$GNGGA,100204.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936364002208772096, '2025-06-21 18:02:08.68766', 194232147738608, '$GNGLL,,,,,100204.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936364006826700800, '2025-06-21 18:02:09.788298', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364013055242240, '2025-06-21 18:02:11.273344', 194232147738608, '$GNGSA,A,1,,,$GNGGA,100207.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936364017685753856, '2025-06-21 18:02:12.377146', 194232147738608, '$GNGLL,,,,,100207.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936364022211407872, '2025-06-21 18:02:13.456163', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,E');
INSERT INTO "public"."device_temp_data" VALUES (1936364026833530880, '2025-06-21 18:02:14.558356', 194232147738608, '$GNZDA,100211.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936364032760082432, '2025-06-21 18:02:15.971069', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364037256376320, '2025-06-21 18:02:17.043774', 194232147738608, '$GNGGA,100212.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364041840750592, '2025-06-21 18:02:18.136055', 194232147738608, '$GNGLL,,,,,100212.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936364046441902080, '2025-06-21 18:02:19.233887', 194232147738608, '$GNGS,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936364050967556096, '2025-06-21 18:02:20.312254', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364055581290496, '2025-06-21 18:02:21.412246', 194232147738608, '$GNZDA,100213.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936364060199219200, '2025-06-21 18:02:22.513489', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364064712290304, '2025-06-21 18:02:23.589629', 194232147738608, '2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936364069271498752, '2025-06-21 18:02:24.676172', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364073818124288, '2025-06-21 18:02:25.760337', 194232147738608, '$GNGGA,100220.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936364078473801728, '2025-06-21 18:02:26.870266', 194232147738608, '$GNGLL,,,,,100220.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936364083007844352, '2025-06-21 18:02:27.951809', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.0*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936364088217169920, '2025-06-21 18:02:29.193769', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364092797349888, '2025-06-21 18:02:30.285725', 194232147738608, '$GNGGA,100223.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936364097390112768, '2025-06-21 18:02:31.380831', 194232147738608, '$GNGLL,,,,,100223.000,1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364102012235776, '2025-06-21 18:02:32.482346', 194232147738608, '$GNGGA,100230.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364106672107520, '2025-06-21 18:02:33.59395', 194232147738608, '$GNGLL,,,,,100230.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936364111248093184, '2025-06-21 18:02:34.684875', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364115866021888, '2025-06-21 18:02:35.785875', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364120425230336, '2025-06-21 18:02:36.872912', 194232147738608, '$GPGSV,1,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936364124980244480, '2025-06-21 18:02:37.958939', 194232147738608, '$GNGGA,100232.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936364129577201664, '2025-06-21 18:02:39.054732', 194232147738608, '$GNGLL,,,,,100232.00,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364134480343040, '2025-06-21 18:02:40.223899', 194232147738608, '$GPGSV,1,1,01,32,,,13,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936364139454787584, '2025-06-21 18:02:41.409366', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364144110465024, '2025-06-21 18:02:42.519056', 194232147738608, '$GNRMC,100237.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936364148694839296, '2025-06-21 18:02:43.61221', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364153228881920, '2025-06-21 18:02:44.693825', 194232147738608, '$GNZDA,100237.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936364157867782144, '2025-06-21 18:02:45.799964', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936364162464739328, '2025-06-21 18:02:46.895675', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364167107833856, '2025-06-21 18:02:48.002829', 194232147738608, '$GNGGA,100240.000BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364171708985344, '2025-06-21 18:02:49.099609', 194232147738608, '$GNRMC,100247.000,V,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936364176326914048, '2025-06-21 18:02:50.200457', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364180839985152, '2025-06-21 18:02:51.276812', 194232147738608, '$GNZDA,100247.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936364185403387904, '2025-06-21 18:02:52.364297', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364190012928000, '2025-06-21 18:02:53.4636', 194232147738608, '$GNGGA,100248.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936364194593107968, '2025-06-21 18:02:54.555675', 194232147738608, '$GNGLL,,,,,100248.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936364199169093632, '2025-06-21 18:02:55.646619', 194232147738608, '$GNGSA,A,1,,,,100248.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936364203770245120, '2025-06-21 18:02:56.743593', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364208304287744, '2025-06-21 18:02:57.824147', 194232147738608, '$GNZDA,100248.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936364212934799360, '2025-06-21 18:02:58.928549', 194232147738608, '$GPTXT,01210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936364217519173632, '2025-06-21 18:03:00.02128', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364222111936512, '2025-06-21 18:03:01.116527', 194232147738608, '$GNZDA,100255.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936364226658562048, '2025-06-21 18:03:02.200705', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364232518004736, '2025-06-21 18:03:03.597528', 194232147738608, '$GNGGA,100256.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364237085601792, '2025-06-21 18:03:04.686277', 194232147738608, '$GNGLL,,,,,100TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364242907295744, '2025-06-21 18:03:06.074113', 194232147738608, '$GNGGA,100303.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936364247525224448, '2025-06-21 18:03:07.175975', 194232147738608, '$GNGLL,,,,,100303.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936364252730355712, '2025-06-21 18:03:08.416933', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364257323118592, '2025-06-21 18:03:09.511282', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364262716993536, '2025-06-21 18:03:10.797762', 194232147738608, '$GPGSV,1,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936364267313950720, '2025-06-21 18:03:11.893401', 194232147738608, '$GNGGA,100305.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936364271969628160, '2025-06-21 18:03:13.003835', 194232147738608, '$GNGLL,,,,,1V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936364276537225216, '2025-06-21 18:03:14.092082', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364281125793792, '2025-06-21 18:03:15.186444', 194232147738608, '$GNZDA,100312.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936364285689196544, '2025-06-21 18:03:16.274051', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364290286153728, '2025-06-21 18:03:17.370195', 194232147738608, '$GNGGA,100313.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364294803419136, '2025-06-21 18:03:18.447771', 194232147738608, '$GNGLL,,,,,100313.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936364299375210496, '2025-06-21 18:03:19.537088', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936364303913447424, '2025-06-21 18:03:20.619706', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364308485238784, '2025-06-21 18:03:21.709014', 194232147738608, '$GNZDA,100313.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936364313023475712, '2025-06-21 18:03:22.791883', 194232147738608, '$GPTXT,01,01,01,AN0*42');
INSERT INTO "public"."device_temp_data" VALUES (1936364317561712640, '2025-06-21 18:03:23.873445', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364322292887552, '2025-06-21 18:03:25.001052', 194232147738608, '$GNGGA,100320.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364326818541568, '2025-06-21 18:03:26.080337', 194232147738608, '$GNGLL,,,,,100320.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936364331373555712, '2025-06-21 18:03:27.166507', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364335957929984, '2025-06-21 18:03:28.259149', 194232147738608, '$GNGSA,A,1,,,,,,NVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364340504555520, '2025-06-21 18:03:29.343014', 194232147738608, '$GNZDA,100320.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936364345130872832, '2025-06-21 18:03:30.446591', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364349719441408, '2025-06-21 18:03:31.5404', 194232147738608, '06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936364354316398592, '2025-06-21 18:03:32.63624', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364358909161472, '2025-06-21 18:03:33.731229', 194232147738608, '$GNGGA,100329.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936364363535478784, '2025-06-21 18:03:34.834341', 194232147738608, '$GNGLL,,,,,100329.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936364368119853056, '2025-06-21 18:03:35.927106', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936364372792307712, '2025-06-21 18:03:37.041216', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364377330544640, '2025-06-21 18:03:38.123231', 194232147738608, '$GNZDA,100329.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936364381914918912, '2025-06-21 18:03:39.2168', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364386482515968, '2025-06-21 18:03:40.305947', 194232147738608, ',N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936364391104638976, '2025-06-21 18:03:41.407302', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364395760316416, '2025-06-21 18:03:42.517671', 194232147738608, '$GNZDA,100336.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936364400369856512, '2025-06-21 18:03:43.616187', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364404899704832, '2025-06-21 18:03:44.696554', 194232147738608, '$GNGGA,100337.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936364409534410752, '2025-06-21 18:03:45.801415', 194232147738608, '$GNGLL,,,,,100*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936364414638878720, '2025-06-21 18:03:47.018077', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364419307139072, '2025-06-21 18:03:48.131165', 194232147738608, ',,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364423878930432, '2025-06-21 18:03:49.221343', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364428454916096, '2025-06-21 18:03:50.31288', 194232147738608, '$GPGSV,1,1,01,32,,,15,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936364433005735936, '2025-06-21 18:03:51.39722', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364437581721600, '2025-06-21 18:03:52.488308', 194232147738608, '$GNRMC,100346.000,V,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936364442187067392, '2025-06-21 18:03:53.586931', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364446758858752, '2025-06-21 18:03:54.67616', 194232147738608, '$GNZDA,100346.000,21,06,2025,00,347.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936364451297095680, '2025-06-21 18:03:55.758975', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364455885664256, '2025-06-21 18:03:56.852842', 194232147738608, '$GNZDA,100347.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936364460499398656, '2025-06-21 18:03:57.952093', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364465104744448, '2025-06-21 18:03:59.050316', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364469668147200, '2025-06-21 18:04:00.138735', 194232147738608, '$GNZDA,100354.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936364474776809472, '2025-06-21 18:04:01.356005', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364479302463488, '2025-06-21 18:04:02.435696', 194232147738608, '$GNGGA,100355.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936364483895226368, '2025-06-21 18:04:03.530111', 194232147738608, '$GNGLL,,,,,100355.000,5');
INSERT INTO "public"."device_temp_data" VALUES (1936364488420880384, '2025-06-21 18:04:04.609146', 194232147738608, '$GNGGA,100403.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936364492929757184, '2025-06-21 18:04:05.684787', 194232147738608, '$GNGLL,,,,,100403.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936364497480577024, '2025-06-21 18:04:06.769527', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364502073339904, '2025-06-21 18:04:07.864447', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364506607382528, '2025-06-21 18:04:08.945436', 194232147738608, '$GPGSV,1,1,01,32,,,15,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936364511145619456, '2025-06-21 18:04:10.027644', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364515729993728, '2025-06-21 18:04:11.120321', 194232147738608, '$GNRMC,100403.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936364520368893952, '2025-06-21 18:04:12.226014', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364524919713792, '2025-06-21 18:04:13.311992', 194232147738608, '$GNZDA,100403.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936364530741407744, '2025-06-21 18:04:14.699476', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364535338364928, '2025-06-21 18:04:15.795447', 194232147738608, '00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936364539905961984, '2025-06-21 18:04:16.884603', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364544528084992, '2025-06-21 18:04:17.986011', 194232147738608, '$GNGGA,100412.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936364549087293440, '2025-06-21 18:04:19.073374', 194232147738608, '$GNGLL,,,,,100412.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936364553747165184, '2025-06-21 18:04:20.184433', 194232147738608, '$GNGSA,A,1,,,,$GNGGA,100413.000,,,,,0,00,25.5,,,,,EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364558285402112, '2025-06-21 18:04:21.266506', 194232147738608, '$GNGGA,100421.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936364562878164992, '2025-06-21 18:04:22.361576', 194232147738608, '$GNGLL,,,,,100421.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936364567483510784, '2025-06-21 18:04:23.459498', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364572042719232, '2025-06-21 18:04:24.546681', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364576622899200, '2025-06-21 18:04:25.638315', 194232147738608, '$GPGSV,1,1,01,32,,,15,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936364581198884864, '2025-06-21 18:04:26.729707', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364585737121792, '2025-06-21 18:04:27.811576', 194232147738608, '$GNRMC,100421.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936364625708838912, '2025-06-21 18:04:37.34157', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364630553260032, '2025-06-21 18:04:38.495026', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364635250880512, '2025-06-21 18:04:39.616964', 194232147738608, '$GPGSV,1,1,01,32,,,17,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936364639893975040, '2025-06-21 18:04:40.72333', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364644629344256, '2025-06-21 18:04:41.852871', 194232147738608, '$GNRMC,100428.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936364649343741952, '2025-06-21 18:04:42.976195', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364654066528256, '2025-06-21 18:04:44.102124', 194232147738608, '$GNZDA,100428.000,A OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364658831257600, '2025-06-21 18:04:45.238957', 194232147738608, '$GNGGA,100439.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936364663411437568, '2025-06-21 18:04:46.330302', 194232147738608, '$GNGLL,,,,,100439.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936364667979034624, '2025-06-21 18:04:47.419235', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01ENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364672559214592, '2025-06-21 18:04:48.511273', 194232147738608, '$GNGGA,100445.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936364677122617344, '2025-06-21 18:04:49.599102', 194232147738608, '$GNGLL,,,,,100445.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936364681732157440, '2025-06-21 18:04:50.698441', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364686400417792, '2025-06-21 18:04:51.811992', 194232147738608, 'NNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364691085455360, '2025-06-21 18:04:52.928818', 194232147738608, '$GNGGA,100448.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936364695653052416, '2025-06-21 18:04:54.017404', 194232147738608, '$GNGLL,,,,,100448.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936364700325507072, '2025-06-21 18:04:55.131704', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364705048293376, '2025-06-21 18:04:56.257743', 194232147738608, '$GNGSA,A,1,,');
INSERT INTO "public"."device_temp_data" VALUES (1936364709653639168, '2025-06-21 18:04:57.355575', 194232147738608, '$GNGGA,100451.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936364714183487488, '2025-06-21 18:04:58.43527', 194232147738608, '$GNGLL,,,,,100451.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936364718763667456, '2025-06-21 18:04:59.527295', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936364723402567680, '2025-06-21 18:05:00.633663', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364728012107776, '2025-06-21 18:05:01.732077', 194232147738608, '$GNZDA,100457.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936364732600676352, '2025-06-21 18:05:02.826859', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364737315074048, '2025-06-21 18:05:03.950068', 194232147738608, '$GNGGA,100458.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936364741920419840, '2025-06-21 18:05:05.048127', 194232147738608, '$GNGLL,,,,,100458.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936364746496405504, '2025-06-21 18:05:06.139067', 194232147738608, '$GNGSA,A,1,,G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364751030448128, '2025-06-21 18:05:07.220049', 194232147738608, '$GNZDA,100459.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936364755560296448, '2025-06-21 18:05:08.300618', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364760123699200, '2025-06-21 18:05:09.388237', 194232147738608, ',,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364764670324736, '2025-06-21 18:05:10.472405', 194232147738608, '$GNZDA,100506.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936364769195978752, '2025-06-21 18:05:11.551015', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364773721632768, '2025-06-21 18:05:12.630082', 194232147738608, '$GNGGA,100507.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936364778318589952, '2025-06-21 18:05:13.726053', 194232147738608, '$GNGLL,,,,,100507.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936364782881992704, '2025-06-21 18:05:14.81473', 194232147738608, '$GNGSA,A,1,TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364787491532800, '2025-06-21 18:05:15.913246', 194232147738608, '$GNZDA,100508.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936364792059129856, '2025-06-21 18:05:17.002507', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364796593172480, '2025-06-21 18:05:18.083431', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364801190129664, '2025-06-21 18:05:19.179756', 194232147738608, '$GPGSV,1,1,01,32,,,13,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936364805757726720, '2025-06-21 18:05:20.268542', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364810325323776, '2025-06-21 18:05:21.357191', 194232147738608, '$GNRMC,100515.000,V,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936364814888726528, '2025-06-21 18:05:22.445434', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364819460517888, '2025-06-21 18:05:23.535815', 194232147738608, '$GNZDA,100515.000,21,06,2VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364824065863680, '2025-06-21 18:05:24.633343', 194232147738608, '$GNZDA,100517.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936364828616683520, '2025-06-21 18:05:25.71846', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364833238806528, '2025-06-21 18:05:26.820051', 194232147738608, '$GNGGA,100524.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936364837852540928, '2025-06-21 18:05:27.920729', 194232147738608, '$GNGLL,,,,,100524.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936364842478858240, '2025-06-21 18:05:29.023939', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364847088398336, '2025-06-21 18:05:30.121935', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364851630829568, '2025-06-21 18:05:31.205958', 194232147738608, '$GPGSV,*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364856173260800, '2025-06-21 18:05:32.288945', 194232147738608, '$GNGGA,100526.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936364860778606592, '2025-06-21 18:05:33.386483', 194232147738608, '$GNGLL,,,,,100526.000,100531.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936364865367175168, '2025-06-21 18:05:34.480598', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364870761050112, '2025-06-21 18:05:35.76623', 194232147738608, '$GNGGA,100532.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936364875353812992, '2025-06-21 18:05:36.861001', 194232147738608, '$GNGLL,,,,,100532.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936364879963353088, '2025-06-21 18:05:37.960495', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364884933603328, '2025-06-21 18:05:39.145471', 194232147738608, '$GNGSA,,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936364889509588992, '2025-06-21 18:05:40.236011', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364894156877824, '2025-06-21 18:05:41.344263', 194232147738608, '$GNGGA,100534.000,DA,100540.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936364898745446400, '2025-06-21 18:05:42.438165', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364903329820672, '2025-06-21 18:05:43.531953', 194232147738608, '$GNGGA,100541.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936364907847086080, '2025-06-21 18:05:44.608477', 194232147738608, '$GNGLL,,,,,100541.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936364912418877440, '2025-06-21 18:05:45.698225', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936364916978085888, '2025-06-21 18:05:46.785266', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364921579237376, '2025-06-21 18:05:47.882295', 194232147738608, '$GPGSV,1,1,,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936364926167805952, '2025-06-21 18:05:48.976898', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364930735403008, '2025-06-21 18:05:50.065052', 194232147738608, ',,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936364935332360192, '2025-06-21 18:05:51.161806', 194232147738608, '$GPGSV,1,1,01,32,,,14,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936364939975454720, '2025-06-21 18:05:52.268497', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936364944517885952, '2025-06-21 18:05:53.351262', 194232147738608, '$GNRMC,100548.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936364949077094400, '2025-06-21 18:05:54.438086', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364953661468672, '2025-06-21 18:05:55.531442', 194232147738608, '$GNZDA,100548.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936364958250037248, '2025-06-21 18:05:56.625288', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25G,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364962830217216, '2025-06-21 18:05:57.717979', 194232147738608, '$GNZDA,100549.000,21,06,2025,00,00*4100,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936364967397814272, '2025-06-21 18:05:58.806327', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936364971957022720, '2025-06-21 18:05:59.893384', 194232147738608, '$GNZDA,100556.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936364976495259648, '2025-06-21 18:06:00.975661', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936364981113188352, '2025-06-21 18:06:02.076008', 194232147738608, '$GNGGA,100557.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936364985831780352, '2025-06-21 18:06:03.201175', 194232147738608, '$GNGLL,,,,,100557.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936364990382600192, '2025-06-21 18:06:04.286001', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.');
INSERT INTO "public"."device_temp_data" VALUES (1936364994920837120, '2025-06-21 18:06:05.368824', 194232147738608, '$GNZDA,100601.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936364999505211392, '2025-06-21 18:06:06.461449', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365004102168576, '2025-06-21 18:06:07.557263', 194232147738608, '$GNGGA,100602.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365008678154240, '2025-06-21 18:06:08.648679', 194232147738608, '$GNGLL,,,,,100602.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936365013262528512, '2025-06-21 18:06:09.741052', 194232147738608, '$GNGSA,A,1,,,,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936365017842708480, '2025-06-21 18:06:10.833417', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365022418694144, '2025-06-21 18:06:11.924595', 194232147738608, '$GNGGA,100605.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936365027003068416, '2025-06-21 18:06:13.017773', 194232147738608, '$GNGLL,,,,,5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365031612608512, '2025-06-21 18:06:14.116636', 194232147738608, '$GPGSV,1,1,01,32,,,06,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936365036176011264, '2025-06-21 18:06:15.204958', 194232147738608, '$BDGSV,1,1,01,19,,,20,0*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365040731025408, '2025-06-21 18:06:16.290876', 194232147738608, '$GNRMC,100611.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936365045294428160, '2025-06-21 18:06:17.378961', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365049908162560, '2025-06-21 18:06:18.478617', 194232147738608, '$GNZDA,100611.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936365054471565312, '2025-06-21 18:06:19.56645', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPE100613.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936365059022385152, '2025-06-21 18:06:20.651833', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25,100619.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936365063556427776, '2025-06-21 18:06:21.732471', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365068182745088, '2025-06-21 18:06:22.835749', 194232147738608, '$GNGGA,100620.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365073056526336, '2025-06-21 18:06:23.997234', 194232147738608, '$GNGLL,,,,,100620.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936365077632512000, '2025-06-21 18:06:25.08803', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365082204303360, '2025-06-21 18:06:26.178839', 194232147738608, '$GNGSA,A,1,,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365086822232064, '2025-06-21 18:06:27.279559', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365092388073472, '2025-06-21 18:06:28.606773', 194232147738608, '$GNZDA,100620.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936365097006002176, '2025-06-21 18:06:29.707902', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365101577793536, '2025-06-21 18:06:30.797753', 194232147738608, '$G1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365119479083008, '2025-06-21 18:06:35.065339', 194232147738608, '$GNGGA,100627.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936365124059262976, '2025-06-21 18:06:36.157674', 194232147738608, '$GNGLL,,,,,100627.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936365128622665728, '2025-06-21 18:06:37.245263', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365133202845696, '2025-06-21 18:06:38.337851', 194232147738608, '$GNGSA,A,1,,,,6,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936365137791414272, '2025-06-21 18:06:39.431357', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365142417731584, '2025-06-21 18:06:40.534352', 194232147738608, 'ZDA,100638.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936365147404759040, '2025-06-21 18:06:41.72385', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365161719918592, '2025-06-21 18:06:45.136477', 194232147738608, '$GNGGA,100639.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936365166253961216, '2025-06-21 18:06:46.217885', 194232147738608, '$GNGLL,,,,,100639.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936365170825752576, '2025-06-21 18:06:47.307786', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365175393349632, '2025-06-21 18:06:48.396892', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365179998695424, '2025-06-21 18:06:49.494701', 194232147738608, '$GNZDA,100639.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936365184557903872, '2025-06-21 18:06:50.581988', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365189142278144, '2025-06-21 18:06:51.674359', 194232147738608, '$GNGGA,100649.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936365193743429632, '2025-06-21 18:06:52.771964', 194232147738608, '$GNGLL,,,,,100649.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936365198277472256, '2025-06-21 18:06:53.852927', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365202836680704, '2025-06-21 18:06:54.939865', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365207391694848, '2025-06-21 18:06:56.025307', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365211955097600, '2025-06-21 18:06:57.113808', 194232147738608, '5,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936365216543666176, '2025-06-21 18:06:58.207407', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365221119651840, '2025-06-21 18:06:59.298408', 194232147738608, '$GNZDA,100650.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936365225720803328, '2025-06-21 18:07:00.395688', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365230296788992, '2025-06-21 18:07:01.486884', 194232147738608, ',,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365234889551872, '2025-06-21 18:07:02.58182', 194232147738608, '$GNZDA,100656.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936365239482314752, '2025-06-21 18:07:03.676937', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365244045717504, '2025-06-21 18:07:04.764837', 194232147738608, '$GNGGA,100657.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365248638480384, '2025-06-21 18:07:05.859616', 194232147738608, '$GNGLL,,,,,100657.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936365253285769216, '2025-06-21 18:07:06.967516', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365257865949184, '2025-06-21 18:07:08.059455', 194232147738608, '$GNGGA,100700707.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936365263326932992, '2025-06-21 18:07:09.361643', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365267902918656, '2025-06-21 18:07:10.452999', 194232147738608, '$GNGGA,100708.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365272453738496, '2025-06-21 18:07:11.537424', 194232147738608, '$GNGLL,,,,,100708.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936365277533040640, '2025-06-21 18:07:12.748318', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365282129997824, '2025-06-21 18:07:13.844056', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365286785675264, '2025-06-21 18:07:14.954768', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365291386826752, '2025-06-21 18:07:16.051006', 194232147738608, '$B,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936365295971201024, '2025-06-21 18:07:17.144073', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365300740124672, '2025-06-21 18:07:18.281613', 194232147738608, 'E');
INSERT INTO "public"."device_temp_data" VALUES (1936365305290944512, '2025-06-21 18:07:19.366082', 194232147738608, '$GNZDA,100716.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936365309913067520, '2025-06-21 18:07:20.468075', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365314468081664, '2025-06-21 18:07:21.554276', 194232147738608, '$GNGGA,100717.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936365319023095808, '2025-06-21 18:07:22.64091', 194232147738608, '$GNGLL,,,,,100717.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936365323590692864, '2025-06-21 18:07:23.729891', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365328175067136, '2025-06-21 18:07:24.822254', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25,100717.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936365332721692672, '2025-06-21 18:07:25.906846', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365337368981504, '2025-06-21 18:07:27.014596', 194232147738608, ',25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365341915607040, '2025-06-21 18:07:28.098795', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365346550312960, '2025-06-21 18:07:29.203358', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365351105327104, '2025-06-21 18:07:30.2891', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365356515979264, '2025-06-21 18:07:31.579905', 194232147738608, '$GNRMC,100725.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936365361037438976, '2025-06-21 18:07:32.657194', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365365730865152, '2025-06-21 18:07:33.77643', 194232147738608, '$GNZDA,100725.000,21,06,2025,00,00*4VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365370281684992, '2025-06-21 18:07:34.86165', 194232147738608, '$GNZDA,100729.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936365374845087744, '2025-06-21 18:07:35.949832', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365379425267712, '2025-06-21 18:07:37.041371', 194232147738608, '$GNGGA,100730.000,,,,,0,00,25.5,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365384009641984, '2025-06-21 18:07:38.134121', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365388648542208, '2025-06-21 18:07:39.240996', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365393958531072, '2025-06-21 18:07:40.506834', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365398672928768, '2025-06-21 18:07:41.630922', 194232147738608, '$GNRMC,100734.000,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936365403290857472, '2025-06-21 18:07:42.731998', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365407933952000, '2025-06-21 18:07:43.838731', 194232147738608, '$GNGGA,100739.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936365412539297792, '2025-06-21 18:07:44.936677', 194232147738608, '$GNGLL,,,,,100739.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936365417077534720, '2025-06-21 18:07:46.01897', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365421611577344, '2025-06-21 18:07:47.099515', 194232147738608, 'V,,,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936365426200145920, '2025-06-21 18:07:48.193268', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365430780325888, '2025-06-21 18:07:49.285154', 194232147738608, '$GNZDA,100741.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936365435356311552, '2025-06-21 18:07:50.376082', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365440045543424, '2025-06-21 18:07:51.494759', 194232147738608, '5');
INSERT INTO "public"."device_temp_data" VALUES (1936365444571197440, '2025-06-21 18:07:52.573281', 194232147738608, '$GNGGA,100747.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365449155571712, '2025-06-21 18:07:53.666625', 194232147738608, '$GNGLL,,,,,100747.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936365453723168768, '2025-06-21 18:07:54.755938', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365458269794304, '2025-06-21 18:07:55.83989', 194232147738608, '$GNGSA,A,1,,,,,,,,,,025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936365462774476800, '2025-06-21 18:07:56.91367', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365467384016896, '2025-06-21 18:07:58.012307', 194232147738608, '$GNGGA,100751.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936365471985168384, '2025-06-21 18:07:59.109354', 194232147738608, '$GNGLL,210625,,,N,V*2F');
INSERT INTO "public"."device_temp_data" VALUES (1936365476590514176, '2025-06-21 18:08:00.207497', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365481216831488, '2025-06-21 18:08:01.310009', 194232147738608, '$GNZDA,100757.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936365485788622848, '2025-06-21 18:08:02.400462', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365490423328768, '2025-06-21 18:08:03.505915', 194232147738608, '$GNGGA,100758.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936365495137726464, '2025-06-21 18:08:04.629323', 194232147738608, '$GNGLL,,,,,100758.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936365499730489344, '2025-06-21 18:08:05.724403', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936365504281309184, '2025-06-21 18:08:06.80963', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365508886654976, '2025-06-21 18:08:07.907885', 194232147738608, ',,,,,100806.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936365513483612160, '2025-06-21 18:08:09.003115', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365518072180736, '2025-06-21 18:08:10.097264', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365522602029056, '2025-06-21 18:08:11.177891', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365527194791936, '2025-06-21 18:08:12.27235', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365531770777600, '2025-06-21 18:08:13.363848', 194232147738608, '$GNRMC,100806.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936365536455815168, '2025-06-21 18:08:14.480076', 194232147738608, '$GNV');
INSERT INTO "public"."device_temp_data" VALUES (1936365541015023616, '2025-06-21 18:08:15.567269', 194232147738608, '$GNGLL,,,,,100807.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936365545549066240, '2025-06-21 18:08:16.648574', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365550183772160, '2025-06-21 18:08:17.753383', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365554965278720, '2025-06-21 18:08:18.893232', 194232147738608, '$GNZDA,100814.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936365559532875776, '2025-06-21 18:08:19.982036', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365564075307008, '2025-06-21 18:08:21.06522', 194232147738608, '$GNGGA,100815.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936365568638709760, '2025-06-21 18:08:22.153007', 194232147738608, '$GNGLL,,,,,100815.5');
INSERT INTO "public"."device_temp_data" VALUES (1936365573185335296, '2025-06-21 18:08:23.237133', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365577748738048, '2025-06-21 18:08:24.325597', 194232147738608, '$GNZDA,100816.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936365582328918016, '2025-06-21 18:08:25.417531', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365586909097984, '2025-06-21 18:08:26.509283', 194232147738608, '$GNN*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365591501860864, '2025-06-21 18:08:27.604654', 194232147738608, '$GNZDA,100822.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936365596077846528, '2025-06-21 18:08:28.69581', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365600720941056, '2025-06-21 18:08:29.802363', 194232147738608, '$GNGGA,100823.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936365605343064064, '2025-06-21 18:08:30.904551', 194232147738608, '$GNGLL,,,,,100823.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936365609931632640, '2025-06-21 18:08:31.998865', 194232147738608, '$GNGSA,A2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365614520201216, '2025-06-21 18:08:33.092857', 194232147738608, '$GNZDA,100824.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936365619188461568, '2025-06-21 18:08:34.205068', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365623772835840, '2025-06-21 18:08:35.298032', 194232147738608, '2.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936365628348821504, '2025-06-21 18:08:36.389117', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365632878669824, '2025-06-21 18:08:37.469897', 194232147738608, '$GNZDA,100832.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936365637425295360, '2025-06-21 18:08:38.553166', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365641997086720, '2025-06-21 18:08:39.643003', 194232147738608, '$GNGGA,100833.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936365646585655296, '2025-06-21 18:08:40.737861', 194232147738608, '$GNGLL,,,,,1008XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365651266498560, '2025-06-21 18:08:41.853173', 194232147738608, '$GNGGA,100834.04');
INSERT INTO "public"."device_temp_data" VALUES (1936365655897010176, '2025-06-21 18:08:42.957638', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365660493967360, '2025-06-21 18:08:44.053135', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365665204170752, '2025-06-21 18:08:45.176141', 194232147738608, '$GNRMC,100842.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936365670094729216, '2025-06-21 18:08:46.342589', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365675627016192, '2025-06-21 18:08:47.661322', 194232147738608, '$GNZDA,100842.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936365680169447424, '2025-06-21 18:08:48.744837', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365684720267264, '2025-06-21 18:08:49.829484', 194232147738608, '$GNGGA,100843.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936365689292058624, '2025-06-21 18:08:50.92', 194232147738608, '$GNGLL,,,,,100843.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936365693905793024, '2025-06-21 18:08:52.019698', 194232147738608, '$GNGC,100843.000,V,,,,,,,210625,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365698477584384, '2025-06-21 18:08:53.109887', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365703032598528, '2025-06-21 18:08:54.195635', 194232147738608, '$GNZDA,100843.000,21,001,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365707562446848, '2025-06-21 18:08:55.275166', 194232147738608, '$GNGGA,100853.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936365712104878080, '2025-06-21 18:08:56.358836', 194232147738608, '$GNGLL,,,,,100853.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936365716638920704, '2025-06-21 18:08:57.439458', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365721189740544, '2025-06-21 18:08:58.52467', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365725740560384, '2025-06-21 18:08:59.60987', 194232147738608, '$GNGGA,100855.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936365730379460608, '2025-06-21 18:09:00.715553', 194232147738608, '$GNGLL,,,,,100855.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936365734984806400, '2025-06-21 18:09:01.813205', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,2,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365739493683200, '2025-06-21 18:09:02.888218', 194232147738608, '$GNZDA,100858.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936365744082251776, '2025-06-21 18:09:03.982289', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365748666626048, '2025-06-21 18:09:05.075536', 194232147738608, '$GNGGA,100859.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936365753217445888, '2025-06-21 18:09:06.160787', 194232147738608, '$GNGLL,,,,,100859.000,V,0*44');
INSERT INTO "public"."device_temp_data" VALUES (1936365757734711296, '2025-06-21 18:09:07.237116', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365762344251392, '2025-06-21 18:09:08.336538', 194232147738608, '$GNGGA,100905.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936365766928625664, '2025-06-21 18:09:09.429926', 194232147738608, '$GNGLL,,,,,100905.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936365771492028416, '2025-06-21 18:09:10.517207', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365776072208384, '2025-06-21 18:09:11.609778', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365780627222528, '2025-06-21 18:09:12.695345', 194232147738608, '$GNGGA,100907.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936365785144487936, '2025-06-21 18:09:13.77279', 194232147738608, '$GN,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936365789741445120, '2025-06-21 18:09:14.86851', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365794292264960, '2025-06-21 18:09:15.953605', 194232147738608, '$GNZDA,100911.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936365798826307584, '2025-06-21 18:09:17.034788', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365803372933120, '2025-06-21 18:09:18.118753', 194232147738608, '$GNGGA,100912.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936365807923752960, '2025-06-21 18:09:19.203971', 194232147738608, '$GNGLL,,,,,100912.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936365812499738624, '2025-06-21 18:09:20.294059', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936365817079918592, '2025-06-21 18:09:21.386805', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365821681070080, '2025-06-21 18:09:22.482638', 194232147738608, '$GNGSA,A,100,V,,,,,,,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936365826231889920, '2025-06-21 18:09:23.56881', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365830879178752, '2025-06-21 18:09:24.676248', 194232147738608, '$GNZDA,100920.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936365835434192896, '2025-06-21 18:09:25.762575', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365839976624128, '2025-06-21 18:09:26.845228', 194232147738608, '$GNGGA,100921.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936365844552609792, '2025-06-21 18:09:27.936792', 194232147738608, '$GNGLL,,,,,100921.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936365849225064448, '2025-06-21 18:09:29.050265', 194232147738608, '$GNG,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365854329532416, '2025-06-21 18:09:30.26733', 194232147738608, '$GNGGA,100922.000,,,,,0,0');
INSERT INTO "public"."device_temp_data" VALUES (1936365858884546560, '2025-06-21 18:09:31.353654', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365863527641088, '2025-06-21 18:09:32.460478', 194232147738608, '$GNGGA,100930.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936365868137181184, '2025-06-21 18:09:33.559193', 194232147738608, '$GNGLL,,,,,100930.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936365872692195328, '2025-06-21 18:09:34.645372', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365877213655040, '2025-06-21 18:09:35.723782', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936365881756086272, '2025-06-21 18:09:36.806778', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936365886281740288, '2025-06-21 18:09:37.885336', 194232147738608, '$BDGSV,1,1,02,13,,1,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365890895474688, '2025-06-21 18:09:38.985537', 194232147738608, 'MC,100938.000,V,,,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936365895500820480, '2025-06-21 18:09:40.083854', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365900336852992, '2025-06-21 18:09:41.236973', 194232147738608, '$GNZDA,100938.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936365904958976000, '2025-06-21 18:09:42.338208', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365909509795840, '2025-06-21 18:09:43.423774', 194232147738608, '$GNGGA,100939.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936365914010284032, '2025-06-21 18:09:44.496822', 194232147738608, '$GNGLL,,,,,100939.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936365918531743744, '2025-06-21 18:09:45.574599', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365923086757888, '2025-06-21 18:09:46.660439', 194232147738608, '$GNGSA,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365927616606208, '2025-06-21 18:09:47.74045', 194232147738608, '$GNZDA,100939.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936365932171620352, '2025-06-21 18:09:48.826708', 194232147738608, '$GPTXT,01,01,01,025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936365936680497152, '2025-06-21 18:09:49.901227', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365941252288512, '2025-06-21 18:09:50.991421', 194232147738608, '$GNGGA,100947.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936365945849245696, '2025-06-21 18:09:52.087423', 194232147738608, '$GNGLL,,,,,100947.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936365950416842752, '2025-06-21 18:09:53.176461', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936365954963468288, '2025-06-21 18:09:54.260341', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.,V,,,,,,,210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936365959560425472, '2025-06-21 18:09:55.356626', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936365964128022528, '2025-06-21 18:09:56.44524', 194232147738608, '$GNZDA,100951.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936365968771117056, '2025-06-21 18:09:57.552696', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936365994226348032, '2025-06-21 18:10:03.621813', 194232147738608, '$GNGN,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936366013226545152, '2025-06-21 18:10:08.151811', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366017802530816, '2025-06-21 18:10:09.242819', 194232147738608, '$GNZDA,100954.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936366022437236736, '2025-06-21 18:10:10.347155', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366026979667968, '2025-06-21 18:10:11.430884', 194232147738608, '$GNGGA,100955.000,,,,,0,00,25.5,,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936366031534682112, '2025-06-21 18:10:12.516456', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366037377347584, '2025-06-21 18:10:13.909967', 194232147738608, '$GNGGA,101011.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936366047934410752, '2025-06-21 18:10:16.426861', 194232147738608, '$GNGLL,,,,,101011.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936366052539756544, '2025-06-21 18:10:17.524603', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366057153490944, '2025-06-21 18:10:18.624245', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366062991962112, '2025-06-21 18:10:20.016122', 194232147738608, '$GPGSV,1,148');
INSERT INTO "public"."device_temp_data" VALUES (1936366067580530688, '2025-06-21 18:10:21.110215', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366084647153664, '2025-06-21 18:10:25.179792', 194232147738608, '00,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936366089248305152, '2025-06-21 18:10:26.276836', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366093807513600, '2025-06-21 18:10:27.363318', 194232147738608, '$GNGGA,101021.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936366098379304960, '2025-06-21 18:10:28.453327', 194232147738608, '$GNGLL,,,,,101021.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936366103076925440, '2025-06-21 18:10:29.573753', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366107912957952, '2025-06-21 18:10:30.726909', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366112484749312, '2025-06-21 18:10:31.816218', 194232147738608, '$GP,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936366117106872320, '2025-06-21 18:10:32.918751', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366121653497856, '2025-06-21 18:10:34.002358', 194232147738608, '.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366126246260736, '2025-06-21 18:10:35.097348', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366130818052096, '2025-06-21 18:10:36.187463', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366135347900416, '2025-06-21 18:10:37.267564', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366139928080384, '2025-06-21 18:10:38.359061', 194232147738608, '$GNRMC,101032.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936366144499871744, '2025-06-21 18:10:39.449564', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366149101023232, '2025-06-21 18:10:40.546327', 194232147738608, '$GNZDA,101032.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936366153723146240, '2025-06-21 18:10:41.648947', 194232147738608, '$GPTXT,01,01,01,A');
INSERT INTO "public"."device_temp_data" VALUES (1936366164838051840, '2025-06-21 18:10:44.298375', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366169367900160, '2025-06-21 18:10:45.378264', 194232147738608, '$GNZDA,101043.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936366175143456768, '2025-06-21 18:10:46.755285', 194232147738608, '$GNGLL,,,,,101043.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936366181619462144, '2025-06-21 18:10:48.299253', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366186237390848, '2025-06-21 18:10:49.400768', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366190788210688, '2025-06-21 18:10:50.485992', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366195401945088, '2025-06-21 18:10:51.585113', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366199952764928, '2025-06-21 18:10:52.670213', 194232147738608, '$GNRMC,101043.000,V,,,,,,,210625,,,N,*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366204553916416, '2025-06-21 18:10:53.767808', 194232147738608, '$GNGGA,101046.000,,,,1,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366211239636992, '2025-06-21 18:10:55.361705', 194232147738608, '$GNGGA,101053.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936366215794651136, '2025-06-21 18:10:56.447368', 194232147738608, '$GNGLL,,,,,101053.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936366220441939968, '2025-06-21 18:10:57.555567', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366225038897152, '2025-06-21 18:10:58.651045', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366229652631552, '2025-06-21 18:10:59.751413', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366244143951872, '2025-06-21 18:11:03.206235', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366249466523648, '2025-06-21 18:11:04.475303', 194232147738608, '$GNRMC,1010GA,101054.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936366254008954880, '2025-06-21 18:11:05.558534', 194232147738608, '$GNGLL,,,,,101054.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366264431800320, '2025-06-21 18:11:08.043224', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,2525,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366268965842944, '2025-06-21 18:11:09.124648', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366273566994432, '2025-06-21 18:11:10.22142', 194232147738608, '$GNZDA,101104.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936366278130397184, '2025-06-21 18:11:11.309222', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366282714771456, '2025-06-21 18:11:12.402132', 194232147738608, '$GNGGA,101105.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936366287311728640, '2025-06-21 18:11:13.498739', 194232147738608, '$GNGLL,,,,,101105.000,V,NA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366291917074432, '2025-06-21 18:11:14.59689', 194232147738608, '$GNGGA,101112.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936366296455311360, '2025-06-21 18:11:15.678582', 194232147738608, '$GNGLL,,,,,101112.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936366300989353984, '2025-06-21 18:11:16.759242', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366305590505472, '2025-06-21 18:11:17.85657', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366310204239872, '2025-06-21 18:11:18.956209', 194232147738608, '$GPGSV,1,1,00,0*65000,V,,,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936366314830557184, '2025-06-21 18:11:20.059032', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366319410737152, '2025-06-21 18:11:21.151579', 194232147738608, '$GNZDA,101113.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936366324049637376, '2025-06-21 18:11:22.257969', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366328675954688, '2025-06-21 18:11:23.360584', 194232147738608, '101119.000,V,,,,,,,210625,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936366333264523264, '2025-06-21 18:11:24.454216', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366337869869056, '2025-06-21 18:11:25.552274', 194232147738608, '$GNZDA,101119.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936366342605238272, '2025-06-21 18:11:26.681606', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366347822952448, '2025-06-21 18:11:27.92432', 194232147738608, '$GNGGA4A');
INSERT INTO "public"."device_temp_data" VALUES (1936366352453464064, '2025-06-21 18:11:29.029495', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366367892697088, '2025-06-21 18:11:32.710315', 194232147738608, '$GNGGA,101122.000,,,,,0,00,2TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366372510625792, '2025-06-21 18:11:33.811946', 194232147738608, '$GNGGA,101130.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936366377044668416, '2025-06-21 18:11:34.892073', 194232147738608, '$GNGLL,,,,,101130.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936366393071104000, '2025-06-21 18:11:38.713567', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366434028482560, '2025-06-21 18:11:48.478243', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366438587691008, '2025-06-21 18:11:49.565511', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366443155288064, '2025-06-21 18:11:50.654115', 194232147738608, '$GNRMC,101130.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936366447752245248, '2025-06-21 18:11:51.750959', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366453070622720, '2025-06-21 18:11:53.018229', 194232147738608, '$GNZDA,101130.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936366457818574848, '2025-06-21 18:11:54.150748', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366462377783296, '2025-06-21 18:11:55.23708', 194232147738608, ',,,,,,210625,,,N,V*2F');
INSERT INTO "public"."device_temp_data" VALUES (1936366466928603136, '2025-06-21 18:11:56.322073', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366471504588800, '2025-06-21 18:11:57.413848', 194232147738608, '$GNZDA,101150.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936366476067991552, '2025-06-21 18:11:58.501867', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366482279755776, '2025-06-21 18:11:59.982999', 194232147738608, '$GNGGA,101151.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936366486948016128, '2025-06-21 18:12:01.095629', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366491490447360, '2025-06-21 18:12:02.178295', 194232147738608, '$GNZDA,101200.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936366496037072896, '2025-06-21 18:12:03.262971', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366500650807296, '2025-06-21 18:12:04.362093', 194232147738608, '$GNGGA,101201.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936366505201627136, '2025-06-21 18:12:05.447002', 194232147738608, '$GNGLL,,,,,101201.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936366509857304576, '2025-06-21 18:12:06.557151', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366514454261760, '2025-06-21 18:12:07.653659', 194232147738608, '$GNGSA,A,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366519038636032, '2025-06-21 18:12:08.746151', 194232147738608, '$GNZDA,101201.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936366523677536256, '2025-06-21 18:12:09.85266', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366528215773184, '2025-06-21 18:12:10.934867', 194232147738608, ',,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366534675001344, '2025-06-21 18:12:12.474585', 194232147738608, '$GNZDA,101207.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936366539381010432, '2025-06-21 18:12:13.596461', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366544531615744, '2025-06-21 18:12:14.824144', 194232147738608, '$GNGGA,101208.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936366549187293184, '2025-06-21 18:12:15.934303', 194232147738608, '$GNGLL,,,,,101208.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936366553796833280, '2025-06-21 18:12:17.033979', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,00,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936366558435733504, '2025-06-21 18:12:18.139038', 194232147738608, '$GNGLL,,,,,101209.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936366563003330560, '2025-06-21 18:12:19.228307', 194232147738608, '$GNGSA,A,1,,,,,,,,,');
INSERT INTO "public"."device_temp_data" VALUES (1936366568137158656, '2025-06-21 18:12:20.452903', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366572729921536, '2025-06-21 18:12:21.54782', 194232147738608, '$GNZDA,101217.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936366577377210368, '2025-06-21 18:12:22.655583', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366581949001728, '2025-06-21 18:12:23.745647', 194232147738608, '$GNGGA,101218.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936366586520793088, '2025-06-21 18:12:24.835838', 194232147738608, '$GNGLL,,,,,101218.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936366591088390144, '2025-06-21 18:12:25.924949', 194232147738608, '$GNGSA,A,1,,,,00,V,,,,,,,210625,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936366595672764416, '2025-06-21 18:12:27.017632', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366600269721600, '2025-06-21 18:12:28.113674', 194232147738608, '$GNZDA,101218.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936366604841512960, '2025-06-21 18:12:29.203071', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366609404915712, '2025-06-21 18:12:30.291045', 194232147738608, '0625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936366613955735552, '2025-06-21 18:12:31.376078', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366618473000960, '2025-06-21 18:12:32.453052', 194232147738608, '$GNZDA,101226.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936366623015432192, '2025-06-21 18:12:33.536817', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366627570446336, '2025-06-21 18:12:34.62299', 194232147738608, '$GNGGA,101227.000,,,,,0,00,26,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936366632146432000, '2025-06-21 18:12:35.713213', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366636697251840, '2025-06-21 18:12:36.79858', 194232147738608, 'TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366641260654592, '2025-06-21 18:12:37.886012', 194232147738608, '$GNGGA,101235.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936366645840834560, '2025-06-21 18:12:38.978606', 194232147738608, '$GNGLL,,,,,101235.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936366650475540480, '2025-06-21 18:12:40.083423', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366655085080576, '2025-06-21 18:12:41.182022', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366659736563712, '2025-06-21 18:12:42.29127', 194232147738608, '$GPGSV,1,1,00,0*6TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366664341909504, '2025-06-21 18:12:43.389552', 194232147738608, '$GNGGA,101236.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936366668880146432, '2025-06-21 18:12:44.471658', 194232147738608, '$GNGLL,,,,,101236.000,V,N*6VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366673485492224, '2025-06-21 18:12:45.569727', 194232147738608, '$GNZDA,101242.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936366678078255104, '2025-06-21 18:12:46.664113', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366682671017984, '2025-06-21 18:12:47.759061', 194232147738608, '$GNGGA,101243.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936366687339278336, '2025-06-21 18:12:48.872487', 194232147738608, '$GNGLL,,,,,101243.000,V,N* OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366691898486784, '2025-06-21 18:12:49.959653', 194232147738608, '$GNGGA,101244.000,,,,,0,00,,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366696457695232, '2025-06-21 18:12:51.046923', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366701029486592, '2025-06-21 18:12:52.136626', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366705639026688, '2025-06-21 18:12:53.235311', 194232147738608, '$GNRMC,101249.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936366710194040832, '2025-06-21 18:12:54.321444', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366714782609408, '2025-06-21 18:12:55.415266', 194232147738608, '$GNZDA,101249.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936366719333429248, '2025-06-21 18:12:56.500172', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366723892637696, '2025-06-21 18:12:57.587115', 194232147738608, '$GNGGA,101250.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936366728435068928, '2025-06-21 18:12:58.670363', 194232147738608, '$GNGL65');
INSERT INTO "public"."device_temp_data" VALUES (1936366732977500160, '2025-06-21 18:12:59.753494', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366737591234560, '2025-06-21 18:13:00.853073', 194232147738608, '$GNRMC,101250.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936366742523736064, '2025-06-21 18:13:02.029518', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366747103916032, '2025-06-21 18:13:03.121319', 194232147738608, '$GNZDA,101250.000,21,06,2025,00,00*00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936366751688290304, '2025-06-21 18:13:04.214032', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366756310413312, '2025-06-21 18:13:05.316069', 194232147738608, '$GNGGA,101259.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366760903176192, '2025-06-21 18:13:06.411716', 194232147738608, '$GNGLL,,,,,101259.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936366765709848576, '2025-06-21 18:13:07.557405', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,*66');
INSERT INTO "public"."device_temp_data" VALUES (1936366770902396928, '2025-06-21 18:13:08.795456', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366775507742720, '2025-06-21 18:13:09.893086', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366780029202432, '2025-06-21 18:13:10.971601', 194232147738608, '$GPGSV,1,1,01,195,,,230,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936366784659714048, '2025-06-21 18:13:12.075879', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366789206339584, '2025-06-21 18:13:13.159322', 194232147738608, '$GNGGA,101308.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936366794512134144, '2025-06-21 18:13:14.424625', 194232147738608, '$GNGLL,,,,,101308.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936366799226531840, '2025-06-21 18:13:15.548773', 194232147738608, '$GNGSA,A,1,,,,SA,A,1,,,,,,,,,,,,,25.5,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936366804318416896, '2025-06-21 18:13:16.762258', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366808894402560, '2025-06-21 18:13:17.853897', 194232147738608, '$GNZDA,101315.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936366813466193920, '2025-06-21 18:13:18.943779', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366818029596672, '2025-06-21 18:13:20.03107', 194232147738608, '$GNGGA,101316.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936366822567833600, '2025-06-21 18:13:21.11377', 194232147738608, '$GNGLL,,,,,101316.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936366827563249664, '2025-06-21 18:13:22.304061', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366832130846720, '2025-06-21 18:13:23.393781', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,GSV,1,1,01,42,,,22,0*73');
INSERT INTO "public"."device_temp_data" VALUES (1936366836723609600, '2025-06-21 18:13:24.488863', 194232147738608, '$GNRMC,101319.000,V,,,,,,,210625,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936366841307983872, '2025-06-21 18:13:25.581264', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366845896552448, '2025-06-21 18:13:26.675685', 194232147738608, '$GNZDA,101319.000,21,06,2025,0');
INSERT INTO "public"."device_temp_data" VALUES (1936366850426400768, '2025-06-21 18:13:27.755634', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366854993997824, '2025-06-21 18:13:28.844411', 194232147738608, '$GNGGA,101324.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936366859616120832, '2025-06-21 18:13:29.946791', 194232147738608, '$GNGLL,,,,,101324.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936366864229855232, '2025-06-21 18:13:31.046539', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,2501,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366868826812416, '2025-06-21 18:13:32.142503', 194232147738608, '$GNGGA,101328.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936366873482489856, '2025-06-21 18:13:33.252905', 194232147738608, '$GNGLL,,,,,101328.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936366878125584384, '2025-06-21 18:13:34.359507', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366882714152960, '2025-06-21 18:13:35.453093', 194232147738608, '$GNGSA,A,1,,,,,,,,,,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936366887260778496, '2025-06-21 18:13:36.53763', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366891849347072, '2025-06-21 18:13:37.631317', 194232147738608, '$GNZDA,101331.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936366896416944128, '2025-06-21 18:13:38.7202', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366901005512704, '2025-06-21 18:13:39.814985', 194232147738608, '$*73');
INSERT INTO "public"."device_temp_data" VALUES (1936366905585692672, '2025-06-21 18:13:40.906928', 194232147738608, '$GNGLL,,,,,101339.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936366910325256192, '2025-06-21 18:13:42.036372', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366915052236800, '2025-06-21 18:13:43.163633', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366919603056640, '2025-06-21 18:13:44.248982', 194232147738608, '$GPGSV,1,1,01,195,,,24,0*5F');
INSERT INTO "public"."device_temp_data" VALUES (1936366924149682176, '2025-06-21 18:13:45.332968', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366928771805184, '2025-06-21 18:13:46.434251', 194232147738608, '$GNRMC,101339.000,V,,,,,,,210625,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936366933331013632, '2025-06-21 18:13:47.521401', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936366937927970816, '2025-06-21 18:13:48.617264', 194232147738608, '$GNZDA,101339.000,21NA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366942587842560, '2025-06-21 18:13:49.728979', 194232147738608, '$GNGGA,101349.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366947126079488, '2025-06-21 18:13:50.810154', 194232147738608, '$GNGLL,,,,,101349.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936366951731425280, '2025-06-21 18:13:51.908573', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366956290633728, '2025-06-21 18:13:52.995967', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936366960824676352, '2025-06-21 18:13:54.076174', 194232147738608, '$GPGSV,1,1,02,28,,,22,195,,,24,0*56');
INSERT INTO "public"."device_temp_data" VALUES (1936366965337747456, '2025-06-21 18:13:55.15271', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936366969909538816, '2025-06-21 18:13:56.242994', 194232147738608, '$GNRMC,101349.000,V,,,,,,,210625,,,N,V*22E');
INSERT INTO "public"."device_temp_data" VALUES (1936366974447775744, '2025-06-21 18:13:57.324997', 194232147738608, '$GNZDA,101356.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936366979027955712, '2025-06-21 18:13:58.416059', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936366983620718592, '2025-06-21 18:13:59.511075', 194232147738608, '$GNGGA,101357.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936366988192509952, '2025-06-21 18:14:00.601287', 194232147738608, '$GNGLL,,,,,101357.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936366992827215872, '2025-06-21 18:14:01.706451', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936366997357064192, '2025-06-21 18:14:02.786296', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367001987575808, '2025-06-21 18:14:03.890577', 194232147738608, '$GPGSV,PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367006530007040, '2025-06-21 18:14:04.972464', 194232147738608, '$GNGGA,101359.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936367011076632576, '2025-06-21 18:14:06.057739', 194232147738608, '$GNGLL,,,,,101359,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367015690366976, '2025-06-21 18:14:07.157551', 194232147738608, '$GPGSV,1,1,01,195,,,21,0*5A');
INSERT INTO "public"."device_temp_data" VALUES (1936367020236992512, '2025-06-21 18:14:08.2413', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367024750063616, '2025-06-21 18:14:09.317058', 194232147738608, '$GNRMC,101404.000,V,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936367029313466368, '2025-06-21 18:14:10.405682', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367033868480512, '2025-06-21 18:14:11.491397', 194232147738608, '$GNZDA,101404.000,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936367038440271872, '2025-06-21 18:14:12.581329', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367043054006272, '2025-06-21 18:14:13.681164', 194232147738608, '$GNZDA,101409.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936367047646769152, '2025-06-21 18:14:14.776986', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367052218560512, '2025-06-21 18:14:15.866082', 194232147738608, '$GNGGA,101410.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936367056769380352, '2025-06-21 18:14:16.951516', 194232147738608, '$GNGLL,,,,,101410.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936367061316005888, '2025-06-21 18:14:18.035808', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367065858437120, '2025-06-21 18:14:19.118185', 194232147738608, '$GNZDA,101411.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936367070367313920, '2025-06-21 18:14:20.193485', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367074892967936, '2025-06-21 18:14:21.27278', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367079473147904, '2025-06-21 18:14:22.364836', 194232147738608, '$GNZDA,101418.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936367084049133568, '2025-06-21 18:14:23.455092', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367088591564800, '2025-06-21 18:14:24.538332', 194232147738608, '$GNGGA,101419.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936367093188521984, '2025-06-21 18:14:25.634104', 194232147738608, '$GNGLL,,,,,101419.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936367097709981696, '2025-06-21 18:14:26.712272', 194232147738608, '$GNGS2D');
INSERT INTO "public"."device_temp_data" VALUES (1936367102281773056, '2025-06-21 18:14:27.802307', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367106908090368, '2025-06-21 18:14:28.905172', 194232147738608, '$GNZDA,101420.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936367111450521600, '2025-06-21 18:14:29.988502', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367115976175616, '2025-06-21 18:14:31.067131', 194232147738608, 'N*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367120539578368, '2025-06-21 18:14:32.155699', 194232147738608, '$GNGGA,101427.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936367125102981120, '2025-06-21 18:14:33.243014', 194232147738608, '$GNGLL,,,,,101427.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367129657995264, '2025-06-21 18:14:34.329487', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367134229786624, '2025-06-21 18:14:35.419676', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936367138835132416, '2025-06-21 18:14:36.517864', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367143369175040, '2025-06-21 18:14:37.598521', 194232147738608, '$GNZDA,101429.000,21,06,2025,');
INSERT INTO "public"."device_temp_data" VALUES (1936367147882246144, '2025-06-21 18:14:38.674276', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367152433065984, '2025-06-21 18:14:39.759777', 194232147738608, '$GNZDA,101437.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936367157050994688, '2025-06-21 18:14:40.860947', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367161773780992, '2025-06-21 18:14:41.986922', 194232147738608, '$GNGGA,101438.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936367166442041344, '2025-06-21 18:14:43.09979', 194232147738608, '$GNGLL,,,,,101438.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936367171001249792, '2025-06-21 18:14:44.186661', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367175497543680, '2025-06-21 18:14:45.258815', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367180031586304, '2025-06-21 18:14:46.339777', 194232147738608, '$G');
INSERT INTO "public"."device_temp_data" VALUES (1936367184582406144, '2025-06-21 18:14:47.424315', 194232147738608, '$GPGSV,1,1,01,195,,,23,0*58');
INSERT INTO "public"."device_temp_data" VALUES (1936367189179363328, '2025-06-21 18:14:48.520344', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367193717600256, '2025-06-21 18:14:49.602892', 194232147738608, '$GNRMC,101441.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936367198272614400, '2025-06-21 18:14:50.68826', 194232147738608, '$G OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367202898931712, '2025-06-21 18:14:51.791226', 194232147738608, '$GNGGA,101447.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936367207428780032, '2025-06-21 18:14:52.871239', 194232147738608, '$GNGLL,,,,,101447.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367211962822656, '2025-06-21 18:14:53.952552', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367216555585536, '2025-06-21 18:14:55.047791', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25DA,101450.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936367221509058560, '2025-06-21 18:14:56.228082', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367226567389184, '2025-06-21 18:14:57.434401', 194232147738608, '$GNGGA,101451.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936367231210483712, '2025-06-21 18:14:58.541359', 194232147738608, '$GN2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936367235773886464, '2025-06-21 18:14:59.6297', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367240303734784, '2025-06-21 18:15:00.709476', 194232147738608, '$GNGGA,101456.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936367244862943232, '2025-06-21 18:15:01.796865', 194232147738608, '$GNGLL,,,,,101456.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367249438928896, '2025-06-21 18:15:02.887472', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,1,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367253964582912, '2025-06-21 18:15:03.966283', 194232147738608, '$GNGGA,101500.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936367258527985664, '2025-06-21 18:15:05.054415', 194232147738608, '$GNGLL,,,,,101500.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936367263112359936, '2025-06-21 18:15:06.147164', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367267738677248, '2025-06-21 18:15:07.250728', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2V,1,1,04,02,,,27,05,,,34,10,,,32,195,,,25,0*5E');
INSERT INTO "public"."device_temp_data" VALUES (1936367272243359744, '2025-06-21 18:15:08.324538', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367277247164416, '2025-06-21 18:15:09.51741', 194232147738608, '$GNRMC,101503.000,V,,,,,,,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936367281806372864, '2025-06-21 18:15:10.604143', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367286382358528, '2025-06-21 18:15:11.695889', 194232147738608, '$GNZDA,101508.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936367291012870144, '2025-06-21 18:15:12.799676', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367296171864064, '2025-06-21 18:15:14.029462', 194232147738608, '$GNGGA,101509.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936367300764626944, '2025-06-21 18:15:15.124957', 194232147738608, '$GNGLL,,,,,101509.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936367305592270848, '2025-06-21 18:15:16.275791', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367310185033728, '2025-06-21 18:15:17.370282', 194232147738608, '$,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367314748436480, '2025-06-21 18:15:18.458912', 194232147738608, '$GNGGA,101517.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936367319349587968, '2025-06-21 18:15:19.55571', 194232147738608, '$GNGLL,,,,,101517.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936367323912990720, '2025-06-21 18:15:20.643509', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367328497364992, '2025-06-21 18:15:21.736258', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367333085933568, '2025-06-21 18:15:22.830235', 194232147738608, '$GPGSV,3,1,10,03,,,31,05,,,34,07,,,32,09,,,33,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936367337653530624, '2025-06-21 18:15:23.919236', 194232147738608, '$GPGSV,3,2,10,10,,,32,1.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936367342305013760, '2025-06-21 18:15:25.028457', 194232147738608, '$GNGLL,,,,,101524.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936367346889388032, '2025-06-21 18:15:26.121368', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367351494733824, '2025-06-21 18:15:27.219552', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367356062330880, '2025-06-21 18:15:28.308016', 194232147738608, '$GPGSV,2,1,08,05,,,34,09,,,33,12,,,35,17,,,32,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936367360621539328, '2025-06-21 18:15:29.395933', 194232147738608, '$GPGSV,2,2,08,28,,,35,30,,,33,195,,,24,197,,,33,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936367365298188288, '2025-06-21 18:15:30.510178', 194232147738608, '$BD,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367369844813824, '2025-06-21 18:15:31.594146', 194232147738608, '$GNGGA,101525.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936367374378856448, '2025-06-21 18:15:32.675045', 194232147738608, '$GNGLL,,,,,101525.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936367378891927552, '2025-06-21 18:15:33.751773', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,221,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936367383438553088, '2025-06-21 18:15:34.835013', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367388018733056, '2025-06-21 18:15:35.927465', 194232147738608, '$GNGGA,101531.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936367392582135808, '2025-06-21 18:15:37.015267', 194232147738608, '$GNGLL,,,,,101531.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367397099401216, '2025-06-21 18:15:38.092091', 194232147738608, '$GNGSGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367401646026752, '2025-06-21 18:15:39.17607', 194232147738608, '$GPGSV,4,1,13,05,,,34,09,,,33,10,,,32,11,,,33,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936367406234595328, '2025-06-21 18:15:40.270598', 194232147738608, '$GPGSV,4,2,13,12,,,35,17,,,32,19,,,33,24,,,21,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936367410944798720, '2025-06-21 18:15:41.393228', 194232147738608, '$GPGSV,4,3,13,28,,,35,30,,,33,194,,');
INSERT INTO "public"."device_temp_data" VALUES (1936367415550144512, '2025-06-21 18:15:42.491919', 194232147738608, '$GNZDA,101538.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936367420205821952, '2025-06-21 18:15:43.601591', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367424802779136, '2025-06-21 18:15:44.697502', 194232147738608, '$GN,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367429336821760, '2025-06-21 18:15:45.778891', 194232147738608, '$GNZDA,101542.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936367433870864384, '2025-06-21 18:15:46.858259', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367438425878528, '2025-06-21 18:15:47.945133', 194232147738608, '$GNGGA,101543.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936367443035418624, '2025-06-21 18:15:49.044974', 194232147738608, '$GNGLL,,,,,101543.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936367447548489728, '2025-06-21 18:15:50.120965', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367452107698176, '2025-06-21 18:15:51.207221', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367456683683840, '2025-06-21 18:15:52.298637', 194232147738608, '$GNGGA,101545.100,,,,,8,195,,,32,197,,,34,0*68');
INSERT INTO "public"."device_temp_data" VALUES (1936367461251280896, '2025-06-21 18:15:53.387605', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367465793712128, '2025-06-21 18:15:54.470849', 194232147738608, '$GNRMC,101551.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936367470629744640, '2025-06-21 18:15:55.623786', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367475243479040, '2025-06-21 18:15:56.723448', 194232147738608, '$GNZDA,101551.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936367479861407744, '2025-06-21 18:15:57.823792', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367484408033280, '2025-06-21 18:15:58.908437', 194232147738608, '$GNGGA,101552.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936367489051127808, '2025-06-21 18:16:00.015638', 194232147738608, '$GNGLL,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367493610336256, '2025-06-21 18:16:01.102046', 194232147738608, '$GNZDA,101552.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936367498203099136, '2025-06-21 18:16:02.197207', 194232147738608, '$GPTXT,01,01,01,ANTENNA $GPGSV,3,2,11,11,,,33,12,,,35,17,,,32,19,,,33,0*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936367502749724672, '2025-06-21 18:16:03.281175', 194232147738608, '$GPGSV,3,3,11,28,,,35,30,,,33,197,,,34,0*52');
INSERT INTO "public"."device_temp_data" VALUES (1936367507329904640, '2025-06-21 18:16:04.373724', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367511931056128, '2025-06-21 18:16:05.470458', 194232147738608, '$GNRMC,101600.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936367516905500672, '2025-06-21 18:16:06.656124', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367521439543296, '2025-06-21 18:16:07.737064', 194232147738608, '$GNZDAGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367525973585920, '2025-06-21 18:16:08.818989', 194232147738608, '$GNRMC,101601.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936367530503434240, '2025-06-21 18:16:09.898613', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367535054254080, '2025-06-21 18:16:10.98328', 194232147738608, '$GNZDA,101601.000,21,06,2025,00,00*GLL,,,,,101608.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936367539588296704, '2025-06-21 18:16:12.06421', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367544134922240, '2025-06-21 18:16:13.148044', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367548647993344, '2025-06-21 18:16:14.224512', 194232147738608, '$GPGSV,3,1,10,04,,,10,07,,');
INSERT INTO "public"."device_temp_data" VALUES (1936367553177841664, '2025-06-21 18:16:15.304241', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367557791576064, '2025-06-21 18:16:16.404302', 194232147738608, '$GPGTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367562346590208, '2025-06-21 18:16:17.490383', 194232147738608, '$GNGGA,101615.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936367566918381568, '2025-06-21 18:16:18.580495', 194232147738608, '$GNGLL,,,,,101615.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936367571498561536, '2025-06-21 18:16:19.672712', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367576040992768, '2025-06-21 18:16:20.755488', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367580541480960, '2025-06-21 18:16:21.828722', 194232147738608, '$GPGSV,2,1,07,04,,,19,07,,,17,11,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936367585029386240, '2025-06-21 18:16:22.898557', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367589525680128, '2025-06-21 18:16:23.970381', 194232147738608, '$GNZDA,101615.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936367594059722752, '2025-06-21 18:16:25.05157', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367598556016640, '2025-06-21 18:16:26.123499', 194232147738608, ',,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367603140390912, '2025-06-21 18:16:27.216168', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367607632490496, '2025-06-21 18:16:28.287768', 194232147738608, '$GPGSV,1,1,02,01,,,20,04,,,18,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936367612179116032, '2025-06-21 18:16:29.371499', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367616662827008, '2025-06-21 18:16:30.44035', 194232147738608, '$GNRMC,101622.000,V,,,,,,,21062,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367621209452544, '2025-06-21 18:16:31.524587', 194232147738608, '$GPGSV,1,1,02,01,,,20,04,,,18,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936367625688969216, '2025-06-21 18:16:32.592426', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367630235594752, '2025-06-21 18:16:33.676547', 194232147738608, '$GNRMC,101623.000,V,,,,,,,210625,,,N,V,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367634757054464, '2025-06-21 18:16:34.754706', 194232147738608, '$GNZDA,101630.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936367639320457216, '2025-06-21 18:16:35.842571', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367643883859968, '2025-06-21 18:16:36.930915', 194232147738608, '$GNGGA,101631.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936367648388542464, '2025-06-21 18:16:38.004322', 194232147738608, '$GNGLL,,,,,101631.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936367652922585088, '2025-06-21 18:16:39.08588', 194232147738608, '$GNGSOPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367657485987840, '2025-06-21 18:16:40.173423', 194232147738608, '$GNGGA,25');
INSERT INTO "public"."device_temp_data" VALUES (1936367662137470976, '2025-06-21 18:16:41.282321', 194232147738608, '$GNGGA,101640.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936367666763788288, '2025-06-21 18:16:42.385473', 194232147738608, '$GNGLL,,,,,101640.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936367671297830912, '2025-06-21 18:16:43.46675', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367675827679232, '2025-06-21 18:16:44.546703', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367680344944640, '2025-06-21 18:16:45.623645', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367685340360704, '2025-06-21 18:16:46.81496', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367689937317888, '2025-06-21 18:16:47.91017', 194232147738608, '$GNRMC,101640.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936367694513303552, '2025-06-21 18:16:49.00116', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367699051540480, '2025-06-21 18:16:50.083157', 194232147738608, '$GNZDA,101640.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936367703627526144, '2025-06-21 18:16:51.174966', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367708153180160, '2025-06-21 18:16:52.2537', 194232147738608, '00,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936367712704000000, '2025-06-21 18:16:53.338861', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367717238042624, '2025-06-21 18:16:54.419506', 194232147738608, '$GNGGA,101650.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936367721767890944, '2025-06-21 18:16:55.499949', 194232147738608, '$GNGLL,,,,,101650.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936367726373236736, '2025-06-21 18:16:56.597706', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01DA,101653.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936367730903085056, '2025-06-21 18:16:57.677357', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367735437127680, '2025-06-21 18:16:58.758148', 194232147738608, '$GNGGA,101654.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936367739971170304, '2025-06-21 18:16:59.839014', 194232147738608, '$GNGLL,,,,,101654.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367744492630016, '2025-06-21 18:17:00.917814', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367749026672640, '2025-06-21 18:17:01.998317', 194232147738608, '$GNGGA,101657.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936367753636212736, '2025-06-21 18:17:03.097535', 194232147738608, '$GNGLL,,,,,101657.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936367758321250304, '2025-06-21 18:17:04.214923', 194232147738608, '$GNGSA,A,1,');
INSERT INTO "public"."device_temp_data" VALUES (1936367762872070144, '2025-06-21 18:17:05.299036', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367767422889984, '2025-06-21 18:17:06.384253', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367771944349696, '2025-06-21 18:17:07.462513', 194232147738608, '$GNRMC,101701.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936367776478392320, '2025-06-21 18:17:08.543102', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367781054377984, '2025-06-21 18:17:09.634599', 194232147738608, '$GNZDA,101701.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936367785580032000, '2025-06-21 18:17:10.713118', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*10625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936367790130851840, '2025-06-21 18:17:11.798645', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367794694254592, '2025-06-21 18:17:12.886666', 194232147738608, '$GNZDA,101704.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936367799207325696, '2025-06-21 18:17:13.962436', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367803728785408, '2025-06-21 18:17:15.040816', 194232147738608, ',,,,,101711.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367808225079296, '2025-06-21 18:17:16.11273', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367812792676352, '2025-06-21 18:17:17.201946', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367817658068992, '2025-06-21 18:17:18.361532', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367822741565440, '2025-06-21 18:17:19.573221', 194232147738608, '$BDGSV,1,1,00,0*,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936367827288190976, '2025-06-21 18:17:20.657296', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367831864176640, '2025-06-21 18:17:21.748023', 194232147738608, '$GNZDA,101714.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936367836591157248, '2025-06-21 18:17:22.87562', 194232147738608, '$GPTXT,XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367841183920128, '2025-06-21 18:17:23.970694', 194232147738608, '$GNGGA,101720.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936367845701185536, '2025-06-21 18:17:25.047163', 194232147738608, '$GNGLL,,,,,101720.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936367850243616768, '2025-06-21 18:17:26.130656', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367854794436608, '2025-06-21 18:17:27.21543', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367859341062144, '2025-06-21 18:17:28.29936', 194232147738608, '$GNGGA,101722.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936367863887687680, '2025-06-21 18:17:29.383127', 194232147738608, '$GNGLL,,,,,101722.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367868392370176, '2025-06-21 18:17:30.457343', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936367872955772928, '2025-06-21 18:17:31.545649', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367877477232640, '2025-06-21 18:17:32.623409', 194232147738608, '$GNZDA,101727.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936367882409734144, '2025-06-21 18:17:33.799127', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367886989914112, '2025-06-21 18:17:34.891279', 194232147738608, '$GNGGA,101728.000,,,,,0,00,251729.000,V,,,,,,,210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936367891515568128, '2025-06-21 18:17:35.970213', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367896070582272, '2025-06-21 18:17:37.056983', 194232147738608, '$GNZDA,101729.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936367900617207808, '2025-06-21 18:17:38.140101', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367905176416256, '2025-06-21 18:17:39.227898', 194232147738608, ',,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367910343798784, '2025-06-21 18:17:40.45967', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367915062390784, '2025-06-21 18:17:41.584584', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936367919726456832, '2025-06-21 18:17:42.696667', 194232147738608, '$GNRMC,101735.000,V,,,,,,,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936367924260499456, '2025-06-21 18:17:43.777668', 194232147738608, '$GNVTG,,,,,,,625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936367928844873728, '2025-06-21 18:17:44.870043', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367933366333440, '2025-06-21 18:17:45.948914', 194232147738608, '$GNZDA,101737.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936367937929736192, '2025-06-21 18:17:47.036133', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367942522499072, '2025-06-21 18:17:48.131538', 194232147738608, ',,,,,101744.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936367948126089216, '2025-06-21 18:17:49.467762', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367952752406528, '2025-06-21 18:17:50.570121', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936367957324197888, '2025-06-21 18:17:51.660542', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367961858240512, '2025-06-21 18:17:52.74125', 194232147738608, '$BDGSV,1,1,00,0*74,,,,210625,,,N,V*2F');
INSERT INTO "public"."device_temp_data" VALUES (1936367966392283136, '2025-06-21 18:17:53.82201', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936367970926325760, '2025-06-21 18:17:54.903614', 194232147738608, '$GNZDA,101747.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936367975460368384, '2025-06-21 18:17:55.984638', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936367979965050880, '2025-06-21 18:17:57.058184', 194232147738608, '5');
INSERT INTO "public"."device_temp_data" VALUES (1936367984528453632, '2025-06-21 18:17:58.146242', 194232147738608, '$GNGGA,101753.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936367989079273472, '2025-06-21 18:17:59.231898', 194232147738608, '$GNGLL,,,,,101753.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936367993613316096, '2025-06-21 18:18:00.312481', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936367998126387200, '2025-06-21 18:18:01.388028', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936368002677207040, '2025-06-21 18:18:02.47304', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368007462907904, '2025-06-21 18:18:03.614231', 194232147738608, '$GNZDA,101755.000,21,06,2025,00,V,,,,,,,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936368013783724032, '2025-06-21 18:18:05.12136', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368018296795136, '2025-06-21 18:18:06.197458', 194232147738608, '$GNZDA,101802.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936368022818254848, '2025-06-21 18:18:07.275024', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368027301965824, '2025-06-21 18:18:08.344037', 194232147738608, '$GNGGA,101803.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936368031886340096, '2025-06-21 18:18:09.437467', 194232147738608, '$GNGLL,,,,,101803.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936368042527289344, '2025-06-21 18:18:11.974143', 194232147738608, '$GNGSA,A,1,,,,,,,V,,,,,,,210625,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936368047090692096, '2025-06-21 18:18:13.062057', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368051633123328, '2025-06-21 18:18:14.145279', 194232147738608, '$GNZDA,101803.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936368056162971648, '2025-06-21 18:18:15.225523', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368060730568704, '2025-06-21 18:18:16.314566', 194232147738608, 'TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368065289777152, '2025-06-21 18:18:17.401991', 194232147738608, '$GNGGA,101811.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936368069836402688, '2025-06-21 18:18:18.485021', 194232147738608, '$GNGLL,,,,,101811.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936368074315919360, '2025-06-21 18:18:19.553512', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.513.000,V,,,,,,,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936368078799630336, '2025-06-21 18:18:20.622404', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368083367227392, '2025-06-21 18:18:21.711866', 194232147738608, '$GNZDA,101813.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936368087897075712, '2025-06-21 18:18:22.791948', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368092431118336, '2025-06-21 18:18:23.872889', 194232147738608, ',,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368097011298304, '2025-06-21 18:18:24.96428', 194232147738608, '$GNZDA,101819.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936368101574701056, '2025-06-21 18:18:26.052028', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368106096160768, '2025-06-21 18:18:27.130721', 194232147738608, '$GNGGA,101820.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936368110600843264, '2025-06-21 18:18:28.204362', 194232147738608, '$GNGLL,,,,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368115130691584, '2025-06-21 18:18:29.284907', 194232147738608, '$GNGGA,101821.000,VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368119614402560, '2025-06-21 18:18:30.353723', 194232147738608, '$GNZDA,101828.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936368124215554048, '2025-06-21 18:18:31.450875', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368128820899840, '2025-06-21 18:18:32.548323', 194232147738608, '$GNGGA,101829.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936368133367525376, '2025-06-21 18:18:33.632061', 194232147738608, '$GNGLL,,,,,101829.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936368137977065472, '2025-06-21 18:18:34.731098', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368142490136576, '2025-06-21 18:18:35.807509', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936368147057733632, '2025-06-21 18:18:36.896259', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368152137035776, '2025-06-21 18:18:38.107672', 194232147738608, ',,,,,101836.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936368157245698048, '2025-06-21 18:18:39.325317', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368161809100800, '2025-06-21 18:18:40.413438', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368166380892160, '2025-06-21 18:18:41.503785', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368170956877824, '2025-06-21 18:18:42.594486', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368177047007232, '2025-06-21 18:18:44.04647', 194232147738608, '$GNRMC,101836.000,V,,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936368181564272640, '2025-06-21 18:18:45.123175', 194232147738608, '$GNVTG,,,,,,,,,N*2E2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368187373383680, '2025-06-21 18:18:46.508361', 194232147738608, '$GNZDA,101841.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936368191878066176, '2025-06-21 18:18:47.582432', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368196403720192, '2025-06-21 18:18:48.661245', 194232147738608, '$GNGGA,101842.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368200946151424, '2025-06-21 18:18:49.744711', 194232147738608, '$GNGLL,,,,,101842.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936368205559885824, '2025-06-21 18:18:50.844063', 194232147738608, '$GNGSA,A,1,,,*22');
INSERT INTO "public"."device_temp_data" VALUES (1936368210165231616, '2025-06-21 18:18:51.942329', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368214762188800, '2025-06-21 18:18:53.038829', 194232147738608, '$GNZDA,101845.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936368219292037120, '2025-06-21 18:18:54.118379', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368223981268992, '2025-06-21 18:18:55.236227', 194232147738608, ',,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368228490145792, '2025-06-21 18:18:56.311752', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368233003216896, '2025-06-21 18:18:57.387581', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368237570813952, '2025-06-21 18:18:58.476237', 194232147738608, '$GNRMC,101851.000,V,,,,,,,210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936368242117439488, '2025-06-21 18:18:59.560859', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368246668259328, '2025-06-21 18:19:00.645403', 194232147738608, '$GNZDA,101851.000,21,,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368251210690560, '2025-06-21 18:19:01.728727', 194232147738608, '$GNGGA,101855.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936368255715373056, '2025-06-21 18:19:02.802272', 194232147738608, '$GNGLL,,,,,101855.000,V,NENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368260811452416, '2025-06-21 18:19:04.017047', 194232147738608, '$GNGGA,101901.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936368278410752000, '2025-06-21 18:19:08.213537', 194232147738608, '$GNGLL,,,,,101901.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936368283007709184, '2025-06-21 18:19:09.309908', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368287571111936, '2025-06-21 18:19:10.397099', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368292960792576, '2025-06-21 18:19:11.682495', 194232147738608, '$GPGSV,1,1,00,0*25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368298870566912, '2025-06-21 18:19:13.091237', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368303392026624, '2025-06-21 18:19:14.169421', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368307959623680, '2025-06-21 18:19:15.25809', 194232147738608, '$GNRMC,101903.0A,101912.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936368312527220736, '2025-06-21 18:19:16.347127', 194232147738608, '$GNGLL,,,,,101912.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936368317115789312, '2025-06-21 18:19:17.441023', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368321654026240, '2025-06-21 18:19:18.523831', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368326146125824, '2025-06-21 18:19:19.594106', 194232147738608, '$GPGSV,1,1,01,05,,,19,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936368330717917184, '2025-06-21 18:19:20.684797', 194232147738608, '$BDGSV,1,1,00,0*7 OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368335277125632, '2025-06-21 18:19:21.771807', 194232147738608, '$GNGGA,101916.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368339827945472, '2025-06-21 18:19:22.856766', 194232147738608, '$GNGGGA,101921.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936368345427341312, '2025-06-21 18:19:24.191875', 194232147738608, '$GNGLL,,,,,101921.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936368349986549760, '2025-06-21 18:19:25.278945', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368360396812288, '2025-06-21 18:19:27.760717', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368364968603648, '2025-06-21 18:19:28.850035', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368369582338048, '2025-06-21 18:19:29.950159', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368374145740800, '2025-06-21 18:19:31.038189', 194232147738608, '$GNRMC,101921.1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368378692366336, '2025-06-21 18:19:32.122254', 194232147738608, '$GNRMC,101923.000,V,,,,,,,2106250,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936368383213826048, '2025-06-21 18:19:33.200625', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368387781423104, '2025-06-21 18:19:34.28943', 194232147738608, '$GNGGA,101933.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936368392357408768, '2025-06-21 18:19:35.380775', 194232147738608, '$GNGLL,,,,,101933.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936368396945977344, '2025-06-21 18:19:36.474586', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368401542934528, '2025-06-21 18:19:37.570275', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368406056005632, '2025-06-21 18:19:38.646013', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368410640379904, '2025-06-21 18:19:39.739676', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368415203782656, '2025-06-21 18:19:40.827902', 194232147738608, 'EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368420757041152, '2025-06-21 18:19:42.151464', 194232147738608, '$GNGGA,101934.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368425286889472, '2025-06-21 18:19:43.23152', 194232147738608, '$GNGLL,,PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368429808349184, '2025-06-21 18:19:44.309126', 194232147738608, '$GNGGA,101940.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936368434388529152, '2025-06-21 18:19:45.401129', 194232147738608, '$GNGLL,,,,,101940.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936368438960320512, '2025-06-21 18:19:46.491868', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368443502751744, '2025-06-21 18:19:47.574524', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368448053571584, '2025-06-21 18:19:48.659665', 194232147738608, '$GPGSV,101946.000,V,,,,,,,210625,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936368452591808512, '2025-06-21 18:19:49.741457', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368457507532800, '2025-06-21 18:19:50.913359', 194232147738608, '$GNZDA,101946.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936368462108684288, '2025-06-21 18:19:52.010443', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368466642726912, '2025-06-21 18:19:53.091699', 194232147738608, '$GNGGA,101947.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936368471218712576, '2025-06-21 18:19:54.182524', 194232147738608, '$GNNGGA,101949.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936368475727589376, '2025-06-21 18:19:55.25798', 194232147738608, '$GNGLL,,,,,101949.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936368480270020608, '2025-06-21 18:19:56.340585', 194232147738608, '$GNGSA,A,1,,,0');
INSERT INTO "public"."device_temp_data" VALUES (1936368486246903808, '2025-06-21 18:19:57.765003', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368490743197696, '2025-06-21 18:19:58.837888', 194232147738608, '$GNGGA,101955.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936368495252074496, '2025-06-21 18:19:59.912419', 194232147738608, '$GNGLL,,,,,101955.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936368499760951296, '2025-06-21 18:20:00.987774', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368504374685696, '2025-06-21 18:20:02.087541', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.55');
INSERT INTO "public"."device_temp_data" VALUES (1936368508980031488, '2025-06-21 18:20:03.185842', 194232147738608, '$GNGGA,101957.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936368516353617920, '2025-06-21 18:20:04.943835', 194232147738608, '$GNGLL,,,,,101957.000,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368520866689024, '2025-06-21 18:20:06.019923', 194232147738608, '$GNGGA,102003.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936368525425897472, '2025-06-21 18:20:07.106125', 194232147738608, '$GNGLL,,,,,102003.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936368529993494528, '2025-06-21 18:20:08.195725', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368534523342848, '2025-06-21 18:20:09.27593', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368539074162688, '2025-06-21 18:20:10.360428', 194232147738608, '$GPGSV,1,1,00,0*000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936368543612399616, '2025-06-21 18:20:11.44296', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368548142247936, '2025-06-21 18:20:12.522764', 194232147738608, '$GNGG2010.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936368552697262080, '2025-06-21 18:20:13.608705', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368557227110400, '2025-06-21 18:20:14.688076', 194232147738608, '$GNZDA,102010.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936368561752764416, '2025-06-21 18:20:15.767617', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368566358110208, '2025-06-21 18:20:16.865939', 194232147738608, '$GNGGA,102011.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936368570892152832, '2025-06-21 18:20:17.946292', 194232147738608, '$GNGLL,,,,,102011.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936368575384252416, '2025-06-21 18:20:19.017643', 194232147738608, '$GNG,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368579918295040, '2025-06-21 18:20:20.097694', 194232147738608, '$GNZDA,102012.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936368584548806656, '2025-06-21 18:20:21.202243', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368589078654976, '2025-06-21 18:20:22.28224', 194232147738608, '*43');
INSERT INTO "public"."device_temp_data" VALUES (1936368593642057728, '2025-06-21 18:20:23.37066', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368598150934528, '2025-06-21 18:20:24.445231', 194232147738608, '$GNGGA,102020.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936368602634645504, '2025-06-21 18:20:25.514909', 194232147738608, '$GNGLL,,,,,102020.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936368607135133696, '2025-06-21 18:20:26.587496', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368611631427584, '2025-06-21 18:20:27.65908', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368616123527168, '2025-06-21 18:20:28.730032', 194232147738608, '$GNGGA,102022.000,,027.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936368620720484352, '2025-06-21 18:20:29.826385', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368625241944064, '2025-06-21 18:20:30.904222', 194232147738608, '$GNGGA,102028.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936368629738237952, '2025-06-21 18:20:31.976633', 194232147738608, '$GNGLL,,,,,102028.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936368634268086272, '2025-06-21 18:20:33.05642', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368638793740288, '2025-06-21 18:20:34.135524', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368643357143040, '2025-06-21 18:20:35.22301', 194232147738608, '$GPGSV,1,1,00,0*PTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368647861825536, '2025-06-21 18:20:36.297788', 194232147738608, '$GNGGA,102029.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936368652974682112, '2025-06-21 18:20:37.516059', 194232147738608, '$GNGLL,,,,,102029.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936368657441615872, '2025-06-21 18:20:38.581821', 194232147738608, '$GNGSA,A,1,,,,,,,,,,A,102035.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936368661950492672, '2025-06-21 18:20:39.656798', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368666564227072, '2025-06-21 18:20:40.756585', 194232147738608, '$GNGGA,102036.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936368671161184256, '2025-06-21 18:20:41.852559', 194232147738608, '$GNGLL,,,,,102036.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936368675741364224, '2025-06-21 18:20:42.944157', 194232147738608, '$GNGSA,A,1,,,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368680304766976, '2025-06-21 18:20:44.032394', 194232147738608, '$GNGGA,102040.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936368684822032384, '2025-06-21 18:20:45.109642', 194232147738608, '$GNGLL,,,,,102040.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936368689343492096, '2025-06-21 18:20:46.187456', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368693827203072, '2025-06-21 18:20:47.25684', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368698411577344, '2025-06-21 18:20:48.349481', 194232147738608, '$GNZDA,102043.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936368702903676928, '2025-06-21 18:20:49.420767', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368707496439808, '2025-06-21 18:20:50.515277', 194232147738608, ',,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368711996928000, '2025-06-21 18:20:51.588848', 194232147738608, '$GNZDA,102048.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936368716509999104, '2025-06-21 18:20:52.664171', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368721090179072, '2025-06-21 18:20:53.75632', 194232147738608, '$GNGGA,102049.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368725578084352, '2025-06-21 18:20:54.826291', 194232147738608, '$GNGLL,,,,,102049.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936368730145681408, '2025-06-21 18:20:55.915538', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368734667141120, '2025-06-21 18:20:56.993177', 194232147738608, '$G25,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368739222155264, '2025-06-21 18:20:58.079608', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368743768780800, '2025-06-21 18:20:59.163082', 194232147738608, '$GNZDA,102049.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936368748294434816, '2025-06-21 18:21:00.242623', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368752828477440, '2025-06-21 18:21:01.323426', 194232147738608, '*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368757383491584, '2025-06-21 18:21:02.409416', 194232147738608, '$GNZDA,102057.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936368761934311424, '2025-06-21 18:21:03.494927', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368766468354048, '2025-06-21 18:21:04.575004', 194232147738608, '$GNGGA,102058.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368770989813760, '2025-06-21 18:21:05.653413', 194232147738608, '$GNGLL,,,,,102058.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936368775523856384, '2025-06-21 18:21:06.734299', 194232147738608, '$G1,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368780477329408, '2025-06-21 18:21:07.91529', 194232147738608, '$GNGGA,102100.000,,,,,0,00,25.5,,,,,,*L,,,,,102107.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936368784990400512, '2025-06-21 18:21:08.991817', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368789511860224, '2025-06-21 18:21:10.069859', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368794125594624, '2025-06-21 18:21:11.169878', 194232147738608, '$GPGSV,2,1,06,05,,,34,09,,,34,13,,,31,17,,,32,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936368798659637248, '2025-06-21 18:21:12.250943', 194232147738608, '$GPGSV,2,2,06,195,,,27,197,,,34,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936368803235622912, '2025-06-21 18:21:13.341508', 194232147738608, '$BDGSV,1,1,00,0*NGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368807782248448, '2025-06-21 18:21:14.425614', 194232147738608, '$GPGSV,2,1,05,05,,,34,09,,,34,13,,,3TXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368812295319552, '2025-06-21 18:21:15.501618', 194232147738608, '$GNGGA,102114.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936368816816779264, '2025-06-21 18:21:16.579909', 194232147738608, '$GNGLL,,,,,102114.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936368821350821888, '2025-06-21 18:21:17.660641', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368825901641728, '2025-06-21 18:21:18.745716', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368830381158400, '2025-06-21 18:21:19.813167', 194232147738608, '$GPGSV,3,1,11,05,,,34,07,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368834927783936, '2025-06-21 18:21:20.897185', 194232147738608, '$GNGGA,102115.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936368839453437952, '2025-06-21 18:21:21.976754', 194232147738608, '$GNGLL,02120.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936368844042006528, '2025-06-21 18:21:23.070945', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368848647352320, '2025-06-21 18:21:24.168688', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368853177200640, '2025-06-21 18:21:25.248512', 194232147738608, '$GPGSV,4,1,15,01,,,30,05,,,34,09,,,33,11,,,33,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936368857736409088, '2025-06-21 18:21:26.335484', 194232147738608, '$GPGSV,4,2,15,12,,,35,16,,OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368862278840320, '2025-06-21 18:21:27.418967', 194232147738608, '$GNGGA,102122.900,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936368866867408896, '2025-06-21 18:21:28.512886', 194232147738608, '$GNGLL,,,,,102122.900,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936368872034791424, '2025-06-21 18:21:29.744196', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,SV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936368876589805568, '2025-06-21 18:21:30.830548', 194232147738608, '$GNRMC,102126.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936368881115459584, '2025-06-21 18:21:31.909197', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368885687250944, '2025-06-21 18:21:32.999892', 194232147738608, '$GNZDA,102126.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936368890217099264, '2025-06-21 18:21:34.079939', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368894763724800, '2025-06-21 18:21:35.163602', 194232147738608, '$,102130.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936368899293573120, '2025-06-21 18:21:36.243732', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368903848587264, '2025-06-21 18:21:37.329098', 194232147738608, '$GNGGA,102131.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936368908504264704, '2025-06-21 18:21:38.439902', 194232147738608, '$GNGLL,,,,,102131.000,V,N*6V,,,,,,,210625,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368913117999104, '2025-06-21 18:21:39.539299', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368917664624640, '2025-06-21 18:21:40.623885', 194232147738608, '$GNZDA,102134.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936368922265776128, '2025-06-21 18:21:41.720789', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368926992756736, '2025-06-21 18:21:42.847069', 194232147738608, '$GNPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936368931627462656, '2025-06-21 18:21:43.95215', 194232147738608, '$GNGGA,102143.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936368936165699584, '2025-06-21 18:21:45.034127', 194232147738608, '$GNGLL,,,,,102143.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936368940733296640, '2025-06-21 18:21:46.12304', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936368945284116480, '2025-06-21 18:21:47.208731', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936368949914628096, '2025-06-21 18:21:48.312306', 194232147738608, '$GPGSV,4,1,13,02,,,32,03,,,31,04,,,33,05,,,34,0*66');
INSERT INTO "public"."device_temp_data" VALUES (1936368954486419456, '2025-06-21 18:21:49.402759', 194232147738608, '$GPGSV,4,2,13,16,,,32,17,,,32,18,,,32,28,,,35,,,33,18,,,32,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936368959184039936, '2025-06-21 18:21:50.522147', 194232147738608, '$GPGSV,4,3,14,19,,,33,26,,,30,30,,,33,32,,,31,0*68');
INSERT INTO "public"."device_temp_data" VALUES (1936368963751636992, '2025-06-21 18:21:51.611689', 194232147738608, '$GPGSV,4,4,14,195,,,25,197,,,34,0*62');
INSERT INTO "public"."device_temp_data" VALUES (1936368968239542272, '2025-06-21 18:21:52.681995', 194232147738608, '$BDGSV,1,1,01,26,,,22,0*71');
INSERT INTO "public"."device_temp_data" VALUES (1936368972752613376, '2025-06-21 18:21:53.757116', 194232147738608, '$GNRMC,102149.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936368977282461696, '2025-06-21 18:21:54.837344', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936368981841670144, '2025-06-21 18:21:55.924804', 194232147738608, '$GNZDA,102149.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936368986379907072, '2025-06-21 18:21:57.006718', 194232147738608, '$GPTXT2,14,12,,,35,16,,,32,17,,,33,18,,,32,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936369000405659648, '2025-06-21 18:22:00.350176', 194232147738608, '$GPGSV,4,3,14,26,,,30,28,,,35,30,,,33,32,,,3PGSV,3,3,12,30,,,33,193,,,33,195,,,23,197,,,33,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1936369004910342144, '2025-06-21 18:22:01.424815', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369009461161984, '2025-06-21 18:22:02.509189', 194232147738608, '$GNRMC,102157.000,V,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936369014028759040, '2025-06-21 18:22:03.598888', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369018583773184, '2025-06-21 18:22:04.684652', 194232147738608, '$GNZDA,102157.000,21,06,2025,00,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369023096844288, '2025-06-21 18:22:05.760443', 194232147738608, '$GNGGA,102202.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936369027639275520, '2025-06-21 18:22:06.843384', 194232147738608, '$GNGLL,,,,,102202.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936369032223649792, '2025-06-21 18:22:07.936526', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369041144934400, '2025-06-21 18:22:10.06301', 194232147738608, '$GNGSA,0,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936369045658005504, '2025-06-21 18:22:11.139173', 194232147738608, '$GNGLL,,,,,102205.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369050238185472, '2025-06-21 18:22:12.231685', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369054822559744, '2025-06-21 18:22:13.324984', 194232147738608, '$GNGSA,A,1,,,09.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936369059356602368, '2025-06-21 18:22:14.40532', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369063957753856, '2025-06-21 18:22:15.50243', 194232147738608, '$GNZDA,102209.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936369068521156608, '2025-06-21 18:22:16.590912', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369073030033408, '2025-06-21 18:22:17.665516', 194232147738608, '$GNGGA,102210.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936369077576658944, '2025-06-21 18:22:18.749939', 194232147738608, '$GN10625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936369082114895872, '2025-06-21 18:22:19.831594', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369086665715712, '2025-06-21 18:22:20.916655', 194232147738608, '$GNZDA,102213.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936369091170398208, '2025-06-21 18:22:21.990574', 194232147738608, '$GPTXT,01,,06,,,33,07,,,31,09,,,33,12,,,35,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936369095750578176, '2025-06-21 18:22:23.082122', 194232147738608, '$GPGSV,3,2,10,16,,,32,17,,,32,28,,,35,30,,,33,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936369100284620800, '2025-06-21 18:22:24.163033', 194232147738608, '$GPGSV,3,3,10,31,,,30,195,,,25,0*5F');
INSERT INTO "public"."device_temp_data" VALUES (1936369104806080512, '2025-06-21 18:22:25.24147', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369109356900352, '2025-06-21 18:22:26.326345', 194232147738608, '$GNRMC,102221.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936369113911914496, '2025-06-21 18:22:27.4121', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369118441762816, '2025-06-21 18:22:28.492538', 194232147738608, '$GNZDA,102221.000,74');
INSERT INTO "public"."device_temp_data" VALUES (1936369122946445312, '2025-06-21 18:22:29.566914', 194232147738608, '$GNRMC,102222.000,V,,,,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936369127467905024, '2025-06-21 18:22:30.644975', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369132014530560, '2025-06-21 18:22:31.728277', 194232147738608, '$GNGGA,102230.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936369136552767488, '2025-06-21 18:22:32.810491', 194232147738608, '$GNGLL,,,,,102230.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936369141128753152, '2025-06-21 18:22:33.901677', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369145616658432, '2025-06-21 18:22:34.971327', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369150171672576, '2025-06-21 18:22:36.057631', 194232147738608, '$GPGSV,4,1,15,01,,,30,02,,,32,05,,,34,06,,,33,0*61');
INSERT INTO "public"."device_temp_data" VALUES (1936369154730881024, '2025-06-21 18:22:37.144241', 194232147738608, '$GP5,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936369159264923648, '2025-06-21 18:22:38.225658', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369163798966272, '2025-06-21 18:22:39.306986', 194232147738608, '');
INSERT INTO "public"."device_temp_data" VALUES (1936369168366563328, '2025-06-21 18:22:40.39545', 194232147738608, '$GNZDA,102237.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936369182883049472, '2025-06-21 18:22:43.856332', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369187375149056, '2025-06-21 18:22:44.927966', 194232147738608, '$GNGGA,102238.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936369191904997376, '2025-06-21 18:22:46.007045', 194232147738608, '$GNGLL,,,,,102238.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936369196401291264, '2025-06-21 18:22:47.079599', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369200910168064, '2025-06-21 18:22:48.154426', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,2F');
INSERT INTO "public"."device_temp_data" VALUES (1936369205440016384, '2025-06-21 18:22:49.234852', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369209990836224, '2025-06-21 18:22:50.319711', 194232147738608, '$GNZDA,102241.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936369214566821888, '2025-06-21 18:22:51.410416', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369219121836032, '2025-06-21 18:22:52.496925', 194232147738608, '248.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936369223643295744, '2025-06-21 18:22:53.574049', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369228139589632, '2025-06-21 18:22:54.646779', 194232147738608, '$GNGGA,102249.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936369232644272128, '2025-06-21 18:22:55.720121', 194232147738608, '$GNGLL,,,,,102249.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936369237161537536, '2025-06-21 18:22:56.797474', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369241670414336, '2025-06-21 18:22:57.872373', 194232147738608, '$GNZDA,102253.000,21,06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936369246179291136, '2025-06-21 18:22:58.947711', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369250696556544, '2025-06-21 18:23:00.024576', 194232147738608, '$GNGGA,102254.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936369255230599168, '2025-06-21 18:23:01.105264', 194232147738608, '$GNGLL,,,,,102254.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936369259794001920, '2025-06-21 18:23:02.193126', 194232147738608, '$GNGS256.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936369264252547072, '2025-06-21 18:23:03.256839', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369268799172608, '2025-06-21 18:23:04.340196', 194232147738608, '$GNZDA,102256.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936369273316438016, '2025-06-21 18:23:05.417999', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369277867257856, '2025-06-21 18:23:06.502185', 194232147738608, ',,,36,30,,,33,193,,,33,195,,,25,0*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936369282967531520, '2025-06-21 18:23:07.718185', 194232147738608, '$BDGSV,1,1,01,46,,,24,0*71');
INSERT INTO "public"."device_temp_data" VALUES (1936369287459631104, '2025-06-21 18:23:08.78922', 194232147738608, '$GNRMC,102302.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936369291976896512, '2025-06-21 18:23:09.866662', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369296477384704, '2025-06-21 18:23:10.939152', 194232147738608, '$XT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369301044981760, '2025-06-21 18:23:12.028078', 194232147738608, '$GNGGA,102306.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936369305633550336, '2025-06-21 18:23:13.122548', 194232147738608, '$GNGLL,,,,,102306.000,V,,32,09,,,33,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936369310167592960, '2025-06-21 18:23:14.203254', 194232147738608, '$GPGSV,4,2,13,11,,,33,12,,,35,15,,,32,16,,,32,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936369314726801408, '2025-06-21 18:23:15.290683', 194232147738608, '$GPGSV,4,3,13,17,,,32,18,,,32,28,,,35,30,,,33,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369319218900992, '2025-06-21 18:23:16.361159', 194232147738608, '$GPGSV,4,4,13,195,,,25,0*5D');
INSERT INTO "public"."device_temp_data" VALUES (1936369323803275264, '2025-06-21 18:23:17.454509', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369328312152064, '2025-06-21 18:23:18.529486', 194232147738608, '$GNRMC,102311.000,V,2313.000,V,,,,,,,210625,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936369332871360512, '2025-06-21 18:23:19.616693', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369337397014528, '2025-06-21 18:23:20.695338', 194232147738608, '$GNZDA,102313.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936369341952028672, '2025-06-21 18:23:21.781325', 194232147738608, '$GPTXT,01,01,01,ANTEN1,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369346515431424, '2025-06-21 18:23:22.869037', 194232147738608, '$GNGGA,102319.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936369351020113920, '2025-06-21 18:23:23.943168', 194232147738608, '$GNGLL,,,,,102319.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936369355545767936, '2025-06-21 18:23:25.022073', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369360100782080, '2025-06-21 18:23:26.108927', 194232147738608, '$GNGSA,,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936369364618047488, '2025-06-21 18:23:27.185875', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369369135312896, '2025-06-21 18:23:28.262207', 194232147738608, '$GNGGA,102321.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936369373627412480, '2025-06-21 18:23:29.333903', 194232147738608, '$GNGLL,,2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369378123706368, '2025-06-21 18:23:30.405494', 194232147738608, '$GNZDA,102326.000,21,06,2025,00,00*4C');
INSERT INTO "public"."device_temp_data" VALUES (1936369382649360384, '2025-06-21 18:23:31.484123', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369387145654272, '2025-06-21 18:23:32.556116', 194232147738608, '$GNGGA,102327.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936369391725834240, '2025-06-21 18:23:33.648318', 194232147738608, '$GNGLL,,,,,102327.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936369396276654080, '2025-06-21 18:23:34.733654', 194232147738608, '$GNGSA,A,1,,,,,,,,0,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936369400802308096, '2025-06-21 18:23:35.812038', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369405361516544, '2025-06-21 18:23:36.899533', 194232147738608, '$GNGGA,102329.000,,,,00,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936369409916530688, '2025-06-21 18:23:37.985011', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369414425407488, '2025-06-21 18:23:39.06083', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369419026558976, '2025-06-21 18:23:40.157087', 194232147738608, '$GPGSV,3,1,12,03,,,31,05,,,34,12,,,35,13,,,28,0*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936369423594156032, '2025-06-21 18:23:41.246947', 194232147738608, '$GPGSV,3,2,12,16,,,32,23,,,30,28,,,35,29,,,30,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936369428170141696, '2025-06-21 18:23:42.337748', 194232147738608, '$GPGSV,3,3,12,30,,,33,193,,,33,192');
INSERT INTO "public"."device_temp_data" VALUES (1936369432670629888, '2025-06-21 18:23:43.410312', 194232147738608, '$GPGSV,3,2,12,16,4E');
INSERT INTO "public"."device_temp_data" VALUES (1936369437196283904, '2025-06-21 18:23:44.489284', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369441692577792, '2025-06-21 18:23:45.561754', 194232147738608, '$GNGGA,102343.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936369446214037504, '2025-06-21 18:23:46.639097', 194232147738608, '$GNGLL,,,,,102343.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936369450777440256, '2025-06-21 18:23:47.727204', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369455307288576, '2025-06-21 18:23:48.807673', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369459874885632, '2025-06-21 18:23:49.896026', 194232147738608, '$GPGSV,2,1,08,03,,,31,05,,,34,06,,,32,09,,NVTG,,,,,,,,,N*2E.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369464379568128, '2025-06-21 18:23:50.970187', 194232147738608, '$GPGSV,3,1,09,02,,,27,03,,,31,05,,,34,06,,,32,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936369482507350016, '2025-06-21 18:23:55.292717', 194232147738608, '$GPGSV,3,2,09,09,,,33,12,,,35,17,,,32,23,,,30,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936369487033004032, '2025-06-21 18:23:56.3714', 194232147738608, '$GPGSV,3,3,09,28,,,35,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369491604795392, '2025-06-21 18:23:57.461787', 194232147738608, '$BDGSV,1,1,01,34,,,23,0*73');
INSERT INTO "public"."device_temp_data" VALUES (1936369496147226624, '2025-06-21 18:23:58.544328', 194232147738608, '$GNRMC,102350.000,V,,,,,,,210625,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369500664492032, '2025-06-21 18:23:59.62123', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369505227894784, '2025-06-21 18:24:00.709562', 194232147738608, '$GNZDA,102350.000,21,061');
INSERT INTO "public"."device_temp_data" VALUES (1936369509791297536, '2025-06-21 18:24:01.797142', 194232147738608, '$GPGSV,4,2,13,09,,,33,12,,,35,16,,,32,17,,,32,0*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936369514308562944, '2025-06-21 18:24:02.874729', 194232147738608, '$GPGSV,4,3,13,18,,,32,23,,,30,28,,,35,30,,,33,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936369518850994176, '2025-06-21 18:24:03.95755', 194232147738608, '$GPGSV,TENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369523376648192, '2025-06-21 18:24:05.036373', 194232147738608, '$GNGGA,102401.000,,,,,0,00,25.5,,,,,,*7C');
INSERT INTO "public"."device_temp_data" VALUES (1936369527889719296, '2025-06-21 18:24:06.112703', 194232147738608, '$GNGLL,,,,,102401.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936369532377624576, '2025-06-21 18:24:07.182523', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369536915861504, '2025-06-21 18:24:08.264894', 194232147738608, '$GNGSA,A,1,,,,31,28,,,35,30,,,33,0*64');
INSERT INTO "public"."device_temp_data" VALUES (1936369541433126912, '2025-06-21 18:24:09.341228', 194232147738608, '$GPGSV,4,4,13,197,,,34,0*5F');
INSERT INTO "public"."device_temp_data" VALUES (1936369545971363840, '2025-06-21 18:24:10.423822', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369550534766592, '2025-06-21 18:24:11.511664', 194232147738608, '$GNRMC,102404.000,V,,,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936369555035254784, '2025-06-21 18:24:12.584088', 194232147738608, '$GNVTG,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936369559560908800, '2025-06-21 18:24:13.663766', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369564040425472, '2025-06-21 18:24:14.731383', 194232147738608, '$GNZDA,102408.000,21,06,2025,00,00*47');
INSERT INTO "public"."device_temp_data" VALUES (1936369568570273792, '2025-06-21 18:24:15.811438', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369573100122112, '2025-06-21 18:24:16.891063', 194232147738608, '$GNGGA,102409.0025');
INSERT INTO "public"."device_temp_data" VALUES (1936369577634164736, '2025-06-21 18:24:17.972935', 194232147738608, '$GNGGA,102416.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936369582159818752, '2025-06-21 18:24:19.051372', 194232147738608, '$GNGLL,,,,,102416.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936369586681278464, '2025-06-21 18:24:20.129463', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369591177572352, '2025-06-21 18:24:21.201893', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369595724197888, '2025-06-21 18:24:22.285495', 194232147738608, '$GPGSV,4,1,13,04,,,32,05,,,34,11,,,33,12,,,35,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369600245657600, '2025-06-21 18:24:23.363756', 194232147738608, '$GPGSV,4,2,13,15,,,32,1OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369604758728704, '2025-06-21 18:24:24.439235', 194232147738608, '$GNGGA,1,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936369609313742848, '2025-06-21 18:24:25.525892', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369613839396864, '2025-06-21 18:24:26.60485', 194232147738608, '$GNZDA,102423.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936369618360856576, '2025-06-21 18:24:27.682823', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369622852956160, '2025-06-21 18:24:28.753721', 194232147738608, '$GNGGA,102424.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936369627370221568, '2025-06-21 18:24:29.830724', 194232147738608, '$GNGLL,,,,,102424.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936369631874904064, '2025-06-21 18:24:30.904749', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369636434112512, '2025-06-21 18:24:31.991935', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,2*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936369640951377920, '2025-06-21 18:24:33.068323', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369645506392064, '2025-06-21 18:24:34.154991', 194232147738608, '$GNZDA,102424.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936369650099154944, '2025-06-21 18:24:35.249606', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369654612226048, '2025-06-21 18:24:36.325314', 194232147738608, 'PGSV,4,2,14,11,,,33,12,,,35,15,,,32,16,,,32,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369659150462976, '2025-06-21 18:24:37.407356', 194232147738608, '$GPGSV,4,3,14,19,,,33,24,,,32,28,,,35,30,,,33,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936369663659339776, '2025-06-21 18:24:38.482639', 194232147738608, '$GPGSV,4,4,14,193,,,33,197,,,34,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936369668218548224, '2025-06-21 18:24:39.569939', 194232147738608, '$BDGSV,1,1,00,0*7416,,,32,0*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369672773562368, '2025-06-21 18:24:40.655309', 194232147738608, '$GPGSV,4,3,14,19,,,33,24,,,32,28,,,35,30,,,33,0*67');
INSERT INTO "public"."device_temp_data" VALUES (1936369677609594880, '2025-06-21 18:24:41.808804', 194232147738608, '$GPGSV,4,4,14,193,,,33,1,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936369682160414720, '2025-06-21 18:24:42.893114', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369686782537728, '2025-06-21 18:24:43.995554', 194232147738608, '$GNZDA,102439.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936369691375300608, '2025-06-21 18:24:45.090951', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369695879983104, '2025-06-21 18:24:46.164319', 194232147738608, '$GNGGA,102441.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936369700380471296, '2025-06-21 18:24:47.237598', 194232147738608, '$GNGLL,,,,,10244GNRMC,102445.000,V,,,,,,,210625,,,N,V*2D');
INSERT INTO "public"."device_temp_data" VALUES (1936369704901931008, '2025-06-21 18:24:48.315202', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369709452750848, '2025-06-21 18:24:49.400528', 194232147738608, '$GNZDA,102445.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936369713965821952, '2025-06-21 18:24:50.476488', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369718470504448, '2025-06-21 18:24:51.550969', 194232147738608, '$GNGGA,102446.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936369722975186944, '2025-06-21 18:24:52.624523', 194232147738608, '$GNGLL,,,,,102446.000,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369727526006784, '2025-06-21 18:24:53.709082', 194232147738608, '$GNGGA,102448.000,,,,,0,00,25.5,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369732051660800, '2025-06-21 18:24:54.788607', 194232147738608, '$GNZDA,102452.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936369736602480640, '2025-06-21 18:24:55.873412', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369741144911872, '2025-06-21 18:24:56.956549', 194232147738608, '$GNGGA,102453.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936369745695731712, '2025-06-21 18:24:58.041674', 194232147738608, '$GNGLL,,,,,102453.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936369750200414208, '2025-06-21 18:24:59.115213', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369754709291008, '2025-06-21 18:25:00.190268', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,DA,102453.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936369759297859584, '2025-06-21 18:25:01.284214', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369763894816768, '2025-06-21 18:25:02.380858', 194232147738608, '0*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936369768458219520, '2025-06-21 18:25:03.468469', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369772983873536, '2025-06-21 18:25:04.547253', 194232147738608, '$GNGGA,102501.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936369777538887680, '2025-06-21 18:25:05.633009', 194232147738608, '$GNGLL,,,,,102501.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936369782077124608, '2025-06-21 18:25:06.715193', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369786560835584, '2025-06-21 18:25:07.784976', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369791094878208, '2025-06-21 18:25:08.86505', 194232147738608, '$GPGSV,2,1,07,03,,,T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369795603755008, '2025-06-21 18:25:09.940877', 194232147738608, '$GNGGA,102504.000,,,,,0,SV,2,1,07,02,,,22,07,,,28,12,,,31,18,,,29,0*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936369800167157760, '2025-06-21 18:25:11.028456', 194232147738608, '$GPGSV,2,2,07,19,,,29,28,,,31,197,,,30,0*55');
INSERT INTO "public"."device_temp_data" VALUES (1936369804688617472, '2025-06-21 18:25:12.106123', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369809184911360, '2025-06-21 18:25:13.178408', 194232147738608, '$GNRMC,102509.000,V,,,,,,,210625,,,N,V*24');
INSERT INTO "public"."device_temp_data" VALUES (1936369813739925504, '2025-06-21 18:25:14.264381', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369818265579520, '2025-06-21 18:25:15.343866', 194232147738608, '$GNZDA,102509.000,21,06,202EN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369822799622144, '2025-06-21 18:25:16.424936', 194232147738608, '$GNGGA,102512.000,,,,,0,00,25.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936369827274944512, '2025-06-21 18:25:17.49143', 194232147738608, '$GNGLL,,,,,102512.000,V,N*61');
INSERT INTO "public"."device_temp_data" VALUES (1936369831901261824, '2025-06-21 18:25:18.594367', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,2ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369836523384832, '2025-06-21 18:25:19.696901', 194232147738608, '$GNGGA,102516.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936369841032261632, '2025-06-21 18:25:20.771511', 194232147738608, '$GNGLL,,,,,102516.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936369845557915648, '2025-06-21 18:25:21.850441', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369850448474112, '2025-06-21 18:25:23.016304', 194232147738608, '$GNGSA,A,1,,,,,*47');
INSERT INTO "public"."device_temp_data" VALUES (1936369855083180032, '2025-06-21 18:25:24.121771', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369859600445440, '2025-06-21 18:25:25.198285', 194232147738608, '$GNGGA,102519.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369864126099456, '2025-06-21 18:25:26.277606', 194232147738608, '$GNGLL,,,,,102519.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936369868672724992, '2025-06-21 18:25:27.361996', 194232147738608, '$GNGSA,A,1,,,,,,1,04,02,,,23,07,,,27,28,,,31,197,,,30,0*54');
INSERT INTO "public"."device_temp_data" VALUES (1936369873240322048, '2025-06-21 18:25:28.450351', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936369877812113408, '2025-06-21 18:25:29.540666', 194232147738608, '$GNRMC,102523.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936369882337767424, '2025-06-21 18:25:30.619341', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369886926336000, '2025-06-21 18:25:31.713113', 194232147738608, '$G02530.000,V,,,,,,,210625,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369891498127360, '2025-06-21 18:25:32.803035', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369895981838336, '2025-06-21 18:25:33.872731', 194232147738608, '$GNZDA,102530.000,21,06,2025,00,00*4D');
INSERT INTO "public"."device_temp_data" VALUES (1936369900520075264, '2025-06-21 18:25:34.954703', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369905100255232, '2025-06-21 18:25:36.046127', 194232147738608, '$GNGGA,102531.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936369909676240896, '2025-06-21 18:25:37.137449', 194232147738608, '$GNGLL,,,,,102531.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936369914206089216, '2025-06-21 18:25:38.217306', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369918744326144, '2025-06-21 18:25:39.299686', 194232147738608, '$GNGSA5.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936369928156344320, '2025-06-21 18:25:41.543112', 194232147738608, '$GNGLL,,,,,102532.000,V,N00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936369932753301504, '2025-06-21 18:25:42.63911', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369937287344128, '2025-06-21 18:25:43.72022', 194232147738608, '$GNGGA,102540.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936369941850746880, '2025-06-21 18:25:44.80802', 194232147738608, '$GNGLL,,,,,102540.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936369946372206592, '2025-06-21 18:25:45.88696', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936369950931415040, '2025-06-21 18:25:46.973269', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936369955427708928, '2025-06-21 18:25:48.04598', 194232147738608, '$GPGSV,1,1,02,02,,,22,0V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936369959991111680, '2025-06-21 18:25:49.133935', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369964621623296, '2025-06-21 18:25:50.237263', 194232147738608, '$GNZDA,102542.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936369969210191872, '2025-06-21 18:25:51.331242', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369973723262976, '2025-06-21 18:25:52.407314', 194232147738608, '$GNZDA,102548.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936369978261499904, '2025-06-21 18:25:53.489393', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936369982753599488, '2025-06-21 18:25:54.560166', 194232147738608, '$GNGGA,102549.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936369987308613632, '2025-06-21 18:25:55.646962', 194232147738608, '$GNGLL,,,,,102549.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936369991876210688, '2025-06-21 18:25:56.735266', 194232147738608, '$GNGSA,A,1,,,VTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936369996485750784, '2025-06-21 18:25:57.834593', 194232147738608, '$GNZDA,102553.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936370001007210496, '2025-06-21 18:25:58.912855', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370005558030336, '2025-06-21 18:25:59.997195', 194232147738608, '$GNGGA,102554.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936370010083684352, '2025-06-21 18:26:01.076896', 194232147738608, '$GNGLL,,,,,102554.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936370014546423808, '2025-06-21 18:26:02.140849', 194232147738608, '$GNGSA,A,1,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936370019080466432, '2025-06-21 18:26:03.221974', 194232147738608, '$GNGLL,,,,,102557.000,V,N*60');
INSERT INTO "public"."device_temp_data" VALUES (1936370023639674880, '2025-06-21 18:26:04.308061', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370028198883328, '2025-06-21 18:26:05.395948', 194232147738608, '$G210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936370032695177216, '2025-06-21 18:26:06.467135', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370037254385664, '2025-06-21 18:26:07.554869', 194232147738608, '$GNZDA,102604.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936370041872314368, '2025-06-21 18:26:08.655291', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370046402162688, '2025-06-21 18:26:09.735501', 194232147738608, '$GNGGA,102605.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936370050944593920, '2025-06-21 18:26:10.818679', 194232147738608, '$GNGLL,,,,,102605.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936370055516385280, '2025-06-21 18:26:11.908733', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370060079788032, '2025-06-21 18:26:12.996735', 194232147738608, '$GN,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936370064613830656, '2025-06-21 18:26:14.077681', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370069139484672, '2025-06-21 18:26:15.156529', 194232147738608, '$GNZDA,102605.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936370073719664640, '2025-06-21 18:26:16.248594', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370078278873088, '2025-06-21 18:26:17.335286', 194232147738608, '06,2025,00,00*4F');
INSERT INTO "public"."device_temp_data" VALUES (1936370082842275840, '2025-06-21 18:26:18.423804', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370087414067200, '2025-06-21 18:26:19.51363', 194232147738608, '$GNGGA,102614.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936370092157825024, '2025-06-21 18:26:20.644841', 194232147738608, '$GNGLL,,,,,102614.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936370096826085376, '2025-06-21 18:26:21.757589', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,,,210625,,,N,V*2B');
INSERT INTO "public"."device_temp_data" VALUES (1936370101498540032, '2025-06-21 18:26:22.871153', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370106099691520, '2025-06-21 18:26:23.968049', 194232147738608, '$GNZDA,102614.000,21,06,2025,00,00*48');
INSERT INTO "public"."device_temp_data" VALUES (1936370110696648704, '2025-06-21 18:26:25.064123', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370115251662848, '2025-06-21 18:26:26.150112', 194232147738608, ',25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370119785705472, '2025-06-21 18:26:27.231422', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370124391051264, '2025-06-21 18:26:28.329728', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370128904122368, '2025-06-21 18:26:29.405439', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370133450747904, '2025-06-21 18:26:30.489143', 194232147738608, '$GNRMC,102622.000,V,,,,,,,210625,,,N,V*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370138139979776, '2025-06-21 18:26:31.607002', 194232147738608, 'V,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370142694993920, '2025-06-21 18:26:32.693123', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370147208065024, '2025-06-21 18:26:33.769423', 194232147738608, '$GNRMC,102623.000,V,,,,,NNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370151834382336, '2025-06-21 18:26:34.872711', 194232147738608, '$GNGGA,102631.000,,,,,0,00,25.5,,,,,,*7D');
INSERT INTO "public"."device_temp_data" VALUES (1936370156435533824, '2025-06-21 18:26:35.969489', 194232147738608, '$GNGLL,,,,,102631.000,V,N*63');
INSERT INTO "public"."device_temp_data" VALUES (1936370161753911296, '2025-06-21 18:26:37.237483', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370166279565312, '2025-06-21 18:26:38.316154', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370170817802240, '2025-06-21 18:26:39.398402', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370175553171456, '2025-06-21 18:26:40.527512', 194232147738608, '$BDGS.5,,,,,,*7F');
INSERT INTO "public"."device_temp_data" VALUES (1936370180175294464, '2025-06-21 18:26:41.629919', 194232147738608, '$GNGLL,,,,,T,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370184726114304, '2025-06-21 18:26:42.714541', 194232147738608, '$GNGGA,102642.000,,,,,0,00,25.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936370189293711360, '2025-06-21 18:26:43.803051', 194232147738608, '$GNGLL,,,,,102642.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936370193844531200, '2025-06-21 18:26:44.888741', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370198378573824, '2025-06-21 18:26:45.969631', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370202988113920, '2025-06-21 18:26:47.068674', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370207509573632, '2025-06-21 18:26:48.14687', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370212043616256, '2025-06-21 18:26:49.22754', 194232147738608, '$GNRMC,102642.000,V,,,,,,,210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936370216682516480, '2025-06-21 18:26:50.333483', 194232147738608, '$GNVTG,,,,,,,,,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936370221191393280, '2025-06-21 18:26:51.408745', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370225763184640, '2025-06-21 18:26:52.498734', 194232147738608, '$GNGGA,102650.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936370230314004480, '2025-06-21 18:26:53.583438', 194232147738608, '$GNGLL,,,,,102650.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936370234885795840, '2025-06-21 18:26:54.673844', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370239407255552, '2025-06-21 18:26:55.751279', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370243953881088, '2025-06-21 18:26:56.835569', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370248517283840, '2025-06-21 18:26:57.923872', 194232147738608, '$BD,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936370253034549248, '2025-06-21 18:26:59.000089', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370257593757696, '2025-06-21 18:27:00.087125', 194232147738608, '$GNZDA,102651.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936370262115217408, '2025-06-21 18:27:01.165355', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370266594734080, '2025-06-21 18:27:02.233162', 194232147738608, ',4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370271191691264, '2025-06-21 18:27:03.32955', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370275704762368, '2025-06-21 18:27:04.405821', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370280255582208, '2025-06-21 18:27:05.490272', 194232147738608, '$GNRMC,102658.000,V,,,,,,,210625,,,N,V*23');
INSERT INTO "public"."device_temp_data" VALUES (1936370284785430528, '2025-06-21 18:27:06.570277', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370289562742784, '2025-06-21 18:27:07.709724', 194232147738608, '$GNZDA,102658.000,21,06,2025,00,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936370296659505152, '2025-06-21 18:27:09.40114', 194232147738608, '$GPT210625,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936370301239685120, '2025-06-21 18:27:10.493267', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370305761144832, '2025-06-21 18:27:11.571306', 194232147738608, '$GNZDA,102707.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936370310316158976, '2025-06-21 18:27:12.657133', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370314816647168, '2025-06-21 18:27:13.730723', 194232147738608, '$GNGGA,102708.000,,,,,0,00,25.5,,,,,,*76');
INSERT INTO "public"."device_temp_data" VALUES (1936370319333912576, '2025-06-21 18:27:14.807141', 194232147738608, '$GNGLL,,,,,102708.000,V,N*68');
INSERT INTO "public"."device_temp_data" VALUES (1936370323863760896, '2025-06-21 18:27:15.887775', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370328364249088, '2025-06-21 18:27:16.96038', 194232147738608, '$GNGS06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936370332885708800, '2025-06-21 18:27:18.038323', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370337419751424, '2025-06-21 18:27:19.119037', 194232147738608, 'V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936370342033485824, '2025-06-21 18:27:20.219995', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370346567528448, '2025-06-21 18:27:21.30078', 194232147738608, '$GNZDA,102717.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936370351177068544, '2025-06-21 18:27:22.399446', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370355807580160, '2025-06-21 18:27:23.503193', 194232147738608, '$GNGGA,102718.000,,,,,0,00,25.5,,,,,,*77');
INSERT INTO "public"."device_temp_data" VALUES (1936370360358400000, '2025-06-21 18:27:24.588133', 194232147738608, '$GNGLL,,,,,102718.000,V,N*69');
INSERT INTO "public"."device_temp_data" VALUES (1936370364955357184, '2025-06-21 18:27:25.68425', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25,,,,,,210625,,,N,V*26');
INSERT INTO "public"."device_temp_data" VALUES (1936370369548120064, '2025-06-21 18:27:26.779445', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370374048608256, '2025-06-21 18:27:27.852302', 194232147738608, '$GNZDA,102718.000,21,06,2025,00,00*45');
INSERT INTO "public"."device_temp_data" VALUES (1936370378599428096, '2025-06-21 18:27:28.937888', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370383104110592, '2025-06-21 18:27:30.011683', 194232147738608, ',,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936370387625570304, '2025-06-21 18:27:31.089439', 194232147738608, '$GNGLL,,,,,102726.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936370392176390144, '2025-06-21 18:27:32.174882', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370396697849856, '2025-06-21 18:27:33.252969', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370401240281088, '2025-06-21 18:27:34.335999', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370405791100928, '2025-06-21 18:27:35.42017', 194232147738608, '$BD5,,,N,V*29');
INSERT INTO "public"."device_temp_data" VALUES (1936370410279006208, '2025-06-21 18:27:36.490422', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370414792077312, '2025-06-21 18:27:37.566964', 194232147738608, '$GNZDA,102735.000,21,06,2025,00,00*4A');
INSERT INTO "public"."device_temp_data" VALUES (1936370419372257280, '2025-06-21 18:27:38.658952', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370424053100544, '2025-06-21 18:27:39.774537', 194232147738608, '$GNGGA,102736.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936370428557783040, '2025-06-21 18:27:40.84835', 194232147738608, '$GNGLL,,,,,102736.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370433075048448, '2025-06-21 18:27:41.925166', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370437642645504, '2025-06-21 18:27:43.014953', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.000,,,,,0,00,25.5,,,,,,*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370442172493824, '2025-06-21 18:27:44.094023', 194232147738608, '$GNGLL,,,,,102739.000,V,N*6A');
INSERT INTO "public"."device_temp_data" VALUES (1936370446740090880, '2025-06-21 18:27:45.183295', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370451232190464, '2025-06-21 18:27:46.254268', 194232147738608, '$GN25,,,N,V*28');
INSERT INTO "public"."device_temp_data" VALUES (1936370455762038784, '2025-06-21 18:27:47.334219', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370460346413056, '2025-06-21 18:27:48.427001', 194232147738608, '$GNZDA,102743.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936370464947564544, '2025-06-21 18:27:49.524104', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370469498384384, '2025-06-21 18:27:50.60979', 194232147738608, '$GNGGA,102744.000,,,,,0,00,25.5,,,,,,*7E');
INSERT INTO "public"."device_temp_data" VALUES (1936370474015649792, '2025-06-21 18:27:51.686726', 194232147738608, '$G49.000,V,,,,,,,210625,,,N,V*22');
INSERT INTO "public"."device_temp_data" VALUES (1936370478608412672, '2025-06-21 18:27:52.781889', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370484325249024, '2025-06-21 18:27:54.144934', 194232147738608, '$GNZDA,102749.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936370488905428992, '2025-06-21 18:27:55.236992', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370494618071040, '2025-06-21 18:27:56.598001', 194232147738608, '$GNGGA,102750.000,,,,,0,00,25.5,,,,,,*7B');
INSERT INTO "public"."device_temp_data" VALUES (1936370499101782016, '2025-06-21 18:27:57.667525', 194232147738608, '$GNGLL,,,,,102750.000,V,N*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370503656796160, '2025-06-21 18:27:58.753352', 194232147738608, '$GNGSA,A,1,,,,,,.5,,,,,,*79');
INSERT INTO "public"."device_temp_data" VALUES (1936370508790624256, '2025-06-21 18:27:59.977424', 194232147738608, '$GNGLL,,,,,102752.000,V,N*67');
INSERT INTO "public"."device_temp_data" VALUES (1936370513320472576, '2025-06-21 18:28:01.057001', 194232147738608, '00,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936370517896458240, '2025-06-21 18:28:02.148384', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370522451472384, '2025-06-21 18:28:03.2341', 194232147738608, '$GNGGA,102801.000,,,,,0,00,25.5,,,,,,*70');
INSERT INTO "public"."device_temp_data" VALUES (1936370526951960576, '2025-06-21 18:28:04.307055', 194232147738608, '$GNGLL,,,,,102801.000,V,N*6E');
INSERT INTO "public"."device_temp_data" VALUES (1936370531494391808, '2025-06-21 18:28:05.390896', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370536024240128, '2025-06-21 18:28:06.470121', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370540528922624, '2025-06-21 18:28:07.544098', 194232147738608, '$GPGSV,1,1,00,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370545062965248, '2025-06-21 18:28:08.625891', 194232147738608, '$BDGSV,1,1,00,0*74,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370549592813568, '2025-06-21 18:28:09.705384', 194232147738608, '$GNZDA,102802.000,21,06,2025,00,00*41');
INSERT INTO "public"."device_temp_data" VALUES (1936370554084913152, '2025-06-21 18:28:10.776858', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370558644121600, '2025-06-21 18:28:11.863279', 194232147738608, 'TG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370563165581312, '2025-06-21 18:28:12.941187', 194232147738608, '$GNZDA,102808.000,21,06,2025,00,00*4B');
INSERT INTO "public"."device_temp_data" VALUES (1936370567691235328, '2025-06-21 18:28:14.02008', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370572300775424, '2025-06-21 18:28:15.119589', 194232147738608, '$GNGGA,102809.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936370576880955392, '2025-06-21 18:28:16.21166', 194232147738608, '$GNGLL,,,,,102809.000,V,N*66');
INSERT INTO "public"."device_temp_data" VALUES (1936370581792485376, '2025-06-21 18:28:17.382036', 194232147738608, '$GNGSA,A,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936370586301362176, '2025-06-21 18:28:18.457716', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370590877347840, '2025-06-21 18:28:19.548632', 194232147738608, '$GNGGA,102815.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936370595440750592, '2025-06-21 18:28:20.636128', 194232147738608, '$GNGLL,,,,,102815.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936370600033513472, '2025-06-21 18:28:21.731626', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370604571750400, '2025-06-21 18:28:22.813468', 194232147738608, '$GNGSA,A,1,,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370609202262016, '2025-06-21 18:28:23.917688', 194232147738608, '$GNGGA,102818.000,,,,,0,00,25.5,,,,,,*78');
INSERT INTO "public"."device_temp_data" VALUES (1936370613740498944, '2025-06-21 18:28:24.999041', 194232147738608, '$GNGLL,,,,,102818.0001,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370618257764352, '2025-06-21 18:28:26.076662', 194232147738608, '$GPGSV,1,1,02,10,,,28,24,,,32,0*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936370622749863936, '2025-06-21 18:28:27.14758', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370627300683776, '2025-06-21 18:28:28.232387', 194232147738608, '$GNRMC,102823.000,V,,,,,,,210625,,,N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936370631780200448, '2025-06-21 18:28:29.300869', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370636351991808, '2025-06-21 18:28:30.390809', 194232147738608, '$GNZDA,102823.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936370640852480000, '2025-06-21 18:28:31.463128', 194232147738608, 'GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370645373939712, '2025-06-21 18:28:32.541962', 194232147738608, '$GNZDA,102825.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936370649928953856, '2025-06-21 18:28:33.627913', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370654442024960, '2025-06-21 18:28:34.70399', 194232147738608, ',01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370658984456192, '2025-06-21 18:28:35.786114', 194232147738608, '$GNGGA,102831.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936370663531081728, '2025-06-21 18:28:36.870317', 194232147738608, '$GNGLL,,,,,102831.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936370668081901568, '2025-06-21 18:28:37.955039', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370672611749888, '2025-06-21 18:28:39.035524', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,02833.000,V,,,,,,,210625,,,N,V*20');
INSERT INTO "public"."device_temp_data" VALUES (1936370677305176064, '2025-06-21 18:28:40.154845', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370681939881984, '2025-06-21 18:28:41.259337', 194232147738608, '$GNZDA,102833.000,21,06,2025,00,00*43');
INSERT INTO "public"."device_temp_data" VALUES (1936370686582976512, '2025-06-21 18:28:42.366668', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370691091853312, '2025-06-21 18:28:43.441216', 194232147738608, ',,210625,,,N,V*2A');
INSERT INTO "public"."device_temp_data" VALUES (1936370695571369984, '2025-06-21 18:28:44.509873', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370700109606912, '2025-06-21 18:28:45.591123', 194232147738608, '$GNZDA,102839.000,21,06,2025,00,00*49');
INSERT INTO "public"."device_temp_data" VALUES (1936370704597512192, '2025-06-21 18:28:46.661592', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370709144137728, '2025-06-21 18:28:47.745014', 194232147738608, '$GNGGA,102840.000,102841.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936370713669791744, '2025-06-21 18:28:48.824215', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370718161891328, '2025-06-21 18:28:49.895527', 194232147738608, '5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370722687545344, '2025-06-21 18:28:50.974337', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370727242559488, '2025-06-21 18:28:52.060981', 194232147738608, '$GPGSV,1,1,03,12,,,31,28,,,32,193,,,29,0*5C');
INSERT INTO "public"."device_temp_data" VALUES (1936370731764019200, '2025-06-21 18:28:53.138765', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370736356782080, '2025-06-21 18:28:54.23376', 194232147738608, '$GNRMC,102848.000,V,,,,,,,210625,,,N,V*2C');
INSERT INTO "public"."device_temp_data" VALUES (1936370745403895808, '2025-06-21 18:28:56.390193', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370749933744128, '2025-06-21 18:28:57.470211', 194232147738608, '49.000,V,N*62');
INSERT INTO "public"."device_temp_data" VALUES (1936370754518118400, '2025-06-21 18:28:58.563112', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370759089909760, '2025-06-21 18:28:59.653586', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370763674284032, '2025-06-21 18:29:00.746982', 194232147738608, '$GPGSV,1,1,02,28,,,32,19,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370768208326656, '2025-06-21 18:29:01.827017', 194232147738608, '$GNGGA,102856.000,,,,,0,00,25.5,,,,,,*72');
INSERT INTO "public"."device_temp_data" VALUES (1936370772683649024, '2025-06-21 18:29:02.894252', 194232147738608, '$GNGLL,,,,,102856.000,V,N*6C');
INSERT INTO "public"."device_temp_data" VALUES (1936370777230274560, '2025-06-21 18:29:03.978467', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370781957255168, '2025-06-21 18:29:05.105582', 194232147738608, '$GNZDA,102858.000,21,06,2025,00,00*4E');
INSERT INTO "public"."device_temp_data" VALUES (1936370786642292736, '2025-06-21 18:29:06.222199', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370791151169536, '2025-06-21 18:29:07.297688', 194232147738608, '2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370795697795072, '2025-06-21 18:29:08.38193', 194232147738608, '$GNZDA,102904.000,21,06,2025,00,00*46');
INSERT INTO "public"."device_temp_data" VALUES (1936370800303140864, '2025-06-21 18:29:09.479818', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370804841377792, '2025-06-21 18:29:10.56148', 194232147738608, '$GNGGA,102905.000,,,,,0,00,25.5,,,,,,*75');
INSERT INTO "public"."device_temp_data" VALUES (1936370809354448896, '2025-06-21 18:29:11.637378', 194232147738608, '$GNGLL,,,,,102905.000,V,N*6B');
INSERT INTO "public"."device_temp_data" VALUES (1936370813884297216, '2025-06-21 18:29:12.717345', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,2210625,,,N,V*27');
INSERT INTO "public"."device_temp_data" VALUES (1936370818430922752, '2025-06-21 18:29:13.801924', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370823086600192, '2025-06-21 18:29:14.911485', 194232147738608, '$GNZDA,102906.000,21,06,2025,00,00*44');
INSERT INTO "public"."device_temp_data" VALUES (1936370827603865600, '2025-06-21 18:29:15.988122', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370832133713920, '2025-06-21 18:29:17.068507', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370836630007808, '2025-06-21 18:29:18.140389', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370841172439040, '2025-06-21 18:29:19.223966', 194232147738608, '$GPGSV,1,1,03,12,,,31,14,,,28,28,,,32,0*63');
INSERT INTO "public"."device_temp_data" VALUES (1936370845698093056, '2025-06-21 18:29:20.302874', 194232147738608, '$BDGSV,1,1,00,05,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370850198581248, '2025-06-21 18:29:21.37544', 194232147738608, '$GPGSV,1,1,02,12,,,31,19,,,29,0*65');
INSERT INTO "public"."device_temp_data" VALUES (1936370854724235264, '2025-06-21 18:29:22.454051', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370859304415232, '2025-06-21 18:29:23.546126', 194232147738608, '$GNRMC,102915.000,V,,,,,,,210625,,,N,V*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370863863623680, '2025-06-21 18:29:24.633891', 194232147738608, '$GNVTG,00*40');
INSERT INTO "public"."device_temp_data" VALUES (1936370868460580864, '2025-06-21 18:29:25.729932', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370872998817792, '2025-06-21 18:29:26.811904', 194232147738608, '$GNGGA,102921.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936370877562220544, '2025-06-21 18:29:27.899232', 194232147738608, '$GNGLL,,,,,102921.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936370882066903040, '2025-06-21 18:29:28.973243', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.N,V*21');
INSERT INTO "public"."device_temp_data" VALUES (1936370886571585536, '2025-06-21 18:29:30.047607', 194232147738608, '$GNVTG,,,,,,,,,N*2E');
INSERT INTO "public"."device_temp_data" VALUES (1936370891118211072, '2025-06-21 18:29:31.131896', 194232147738608, '$GNZDA,102922.000,21,06,2025,00,00*42');
INSERT INTO "public"."device_temp_data" VALUES (1936370895648059392, '2025-06-21 18:29:32.21101', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370900173713408, '2025-06-21 18:29:33.290002', 194232147738608, 'NNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370904674201600, '2025-06-21 18:29:34.363264', 194232147738608, '$GNGGA,102930.000,,,,,0,00,25.5,,,,,,*73');
INSERT INTO "public"."device_temp_data" VALUES (1936370909204049920, '2025-06-21 18:29:35.443851', 194232147738608, '$GNGLL,,,,,102930.000,V,N*6D');
INSERT INTO "public"."device_temp_data" VALUES (1936370913738092544, '2025-06-21 18:29:36.524743', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370918343438336, '2025-06-21 18:29:37.622215', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.540');
INSERT INTO "public"."device_temp_data" VALUES (1936370922835537920, '2025-06-21 18:29:38.693427', 194232147738608, '$GPTXT,01,01,01,ANTENNA OPEN*25');
INSERT INTO "public"."device_temp_data" VALUES (1936370927428300800, '2025-06-21 18:29:39.788999', 194232147738608, '$GNGGA,102932.000GA,102939.000,,,,,0,00,25.5,,,,,,*7A');
INSERT INTO "public"."device_temp_data" VALUES (1936370931974926336, '2025-06-21 18:29:40.872406', 194232147738608, '$GNGLL,,,,,102939.000,V,N*64');
INSERT INTO "public"."device_temp_data" VALUES (1936370936609632256, '2025-06-21 18:29:41.977955', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370941173035008, '2025-06-21 18:29:43.065999', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370955421085696, '2025-06-21 18:29:46.462104', 194232147738608, '$GNGGA,102945.000,,,,,0,00,25.5,,,,,,*71');
INSERT INTO "public"."device_temp_data" VALUES (1936370959984488448, '2025-06-21 18:29:47.550985', 194232147738608, '$GNGLL,,,,,102945.000,V,N*6F');
INSERT INTO "public"."device_temp_data" VALUES (1936370964615000064, '2025-06-21 18:29:48.65474', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,1*01');
INSERT INTO "public"."device_temp_data" VALUES (1936370969400700928, '2025-06-21 18:29:49.795664', 194232147738608, '$GNGSA,A,1,,,,,,,,,,,,,25.5,25.5,25.5,4*04');
INSERT INTO "public"."device_temp_data" VALUES (1936370973926354944, '2025-06-21 18:29:50.874934', 194232147738608, '$GPGSV,1,1,01,07,,,28,0*69');
INSERT INTO "public"."device_temp_data" VALUES (1936370978443620352, '2025-06-21 18:29:51.951299', 194232147738608, '$BDGSV,1,1,00,0*74');
INSERT INTO "public"."device_temp_data" VALUES (1936370982994440192, '2025-06-21 18:29:53.036787', 194232147738608, '$GNRMC,102945.000,V,,,,,,,210625,,,N,V*20');

-- ----------------------------
-- Table structure for device_txt_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_txt_data";
CREATE TABLE "public"."device_txt_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "device_xx" int4,
  "device_yy" int4,
  "device_zz" varchar(255) COLLATE "pg_catalog"."default",
  "device_info" varchar(255) COLLATE "pg_catalog"."default",
  "create_time" timestamp(6) NOT NULL
)
;
COMMENT ON COLUMN "public"."device_txt_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_txt_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_txt_data"."device_xx" IS '当前消息的语句总数';
COMMENT ON COLUMN "public"."device_txt_data"."device_yy" IS '当先消息编号';
COMMENT ON COLUMN "public"."device_txt_data"."device_zz" IS '00=错误信息；01=警告信息；02=通知信息；07=用户信息。';
COMMENT ON COLUMN "public"."device_txt_data"."device_info" IS 'ANTENNA_OPEN=天线开路,ANTENNA_OK=天线良好,ANTENNA_SHORT=天线短路';
COMMENT ON COLUMN "public"."device_txt_data"."create_time" IS '消息创建时间';
COMMENT ON TABLE "public"."device_txt_data" IS '来自设备的天线信息';

-- ----------------------------
-- Records of device_txt_data
-- ----------------------------

-- ----------------------------
-- Table structure for device_vtg_data
-- ----------------------------
DROP TABLE IF EXISTS "public"."device_vtg_data";
CREATE TABLE "public"."device_vtg_data" (
  "id" int8 NOT NULL,
  "device_id" int8 NOT NULL,
  "data_time" timestamp(6),
  "cogt" float4,
  "cogm" float4,
  "sog" float4,
  "kph" float4,
  "mode" char(1) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."device_vtg_data"."id" IS '主键';
COMMENT ON COLUMN "public"."device_vtg_data"."device_id" IS '设备id';
COMMENT ON COLUMN "public"."device_vtg_data"."data_time" IS '数据时间';
COMMENT ON COLUMN "public"."device_vtg_data"."cogt" IS '对地真北航向,单位为度，范围：000-359度';
COMMENT ON COLUMN "public"."device_vtg_data"."cogm" IS '对地磁北航向,单位为度，范围：000-359度';
COMMENT ON COLUMN "public"."device_vtg_data"."sog" IS '对地速度,单位为节，范围：00.0-999.9节';
COMMENT ON COLUMN "public"."device_vtg_data"."kph" IS '单位为千米每小时，00.0至1851公里／小时';
COMMENT ON COLUMN "public"."device_vtg_data"."mode" IS '定位模式，A自主模式E估算模式（航位推算）N数据无效D差分模式M未定位，但存在外部输入或历史保存的位置';
COMMENT ON TABLE "public"."device_vtg_data" IS '来自设备的vtg数据';

-- ----------------------------
-- Records of device_vtg_data
-- ----------------------------

-- ----------------------------
-- Table structure for file_storage_records
-- ----------------------------
DROP TABLE IF EXISTS "public"."file_storage_records";
CREATE TABLE "public"."file_storage_records" (
  "id" int8 NOT NULL,
  "file_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "file_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "file_size" numeric NOT NULL,
  "file_path" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "on_deleted" int2 NOT NULL DEFAULT 0,
  "upload_time" timestamp(6) NOT NULL,
  "file_storage_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "file_base_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."file_storage_records"."id" IS 'id';
COMMENT ON COLUMN "public"."file_storage_records"."file_name" IS '文件名称 重新命名的名称';
COMMENT ON COLUMN "public"."file_storage_records"."file_type" IS '文件类型';
COMMENT ON COLUMN "public"."file_storage_records"."file_size" IS '文件大小（MB）';
COMMENT ON COLUMN "public"."file_storage_records"."file_path" IS '文件存储的地址';
COMMENT ON COLUMN "public"."file_storage_records"."on_deleted" IS '是否删除 0 未删除 1删除';
COMMENT ON COLUMN "public"."file_storage_records"."upload_time" IS '上传时间';
COMMENT ON COLUMN "public"."file_storage_records"."file_storage_type" IS '文件存储类型 local minio oss~~';
COMMENT ON COLUMN "public"."file_storage_records"."file_base_name" IS '文件原来的名称';
COMMENT ON TABLE "public"."file_storage_records" IS '文件存储记录表';

-- ----------------------------
-- Records of file_storage_records
-- ----------------------------
INSERT INTO "public"."file_storage_records" VALUES (1952616400048676864, '1952616400048676864', 'png', 1.38830852508545, '\src\user\20170311521952616400048676864', 0, '2025-08-05 14:23:22.302541', 'LOCAL', 'dcc887.png');
INSERT INTO "public"."file_storage_records" VALUES (1967774729565655040, '1967774729565655040', 'jpg', 0.00469493865966797, '\src\user\admin1967774729565655040', 0, '2025-09-16 10:17:09.675702', 'LOCAL', 'c35588.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967774803687395328, '1967774803687395328', 'jpg', 0.00469493865966797, '\src\user\admin1967774803687395328', 0, '2025-09-16 10:17:27.34499', 'LOCAL', 'e5175a.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967775057568616448, '1967775057568616448', 'jpg', 0.00469493865966797, '\src\user\admin1967775057568616448', 0, '2025-09-16 10:18:27.87827', 'LOCAL', '464e29.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967775289169694720, '1967775289169694720', 'jpg', 0.00469493865966797, '\src\user\admin1967775289169694720', 0, '2025-09-16 10:19:23.093556', 'LOCAL', '37e16f.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967775460871917568, '1967775460871917568', 'jpg', 0.00469493865966797, '\src\user\admin1967775460871917568', 0, '2025-09-16 10:20:04.029058', 'LOCAL', '503fca.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967775620129640448, '1967775620129640448', 'jpg', 0.00469493865966797, '\src\user\admin1967775620129640448', 0, '2025-09-16 10:20:42.000516', 'LOCAL', '8691e5.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967777505238630400, '1967777505238630400', 'jpg', 0.00469493865966797, '\src\user\admin1967777505238630400', 0, '2025-09-16 10:28:11.456659', 'LOCAL', '83db62.jpg');
INSERT INTO "public"."file_storage_records" VALUES (1967778077937254400, '1967778077937254400', 'jpg', 0.00469493865966797, '\src\user\admin1967778077937254400', 0, '2025-09-16 10:30:27.990617', 'LOCAL', '1bd9cb.jpg');

-- ----------------------------
-- Table structure for sys_permissions
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_permissions";
CREATE TABLE "public"."sys_permissions" (
  "permission_id" int8 NOT NULL,
  "perm_key" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "perm_name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "perm_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "parent_id" int8,
  "component_path" varchar(255) COLLATE "pg_catalog"."default",
  "sort_order" int4 DEFAULT 0,
  "is_hidden" bool DEFAULT false,
  "created_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "allow_delete" int2 NOT NULL DEFAULT 0
)
;
COMMENT ON COLUMN "public"."sys_permissions"."permission_id" IS 'id';
COMMENT ON COLUMN "public"."sys_permissions"."perm_key" IS '权限键(如: menu:sysmgmt, func:user:create)';
COMMENT ON COLUMN "public"."sys_permissions"."perm_name" IS '权限显示名称';
COMMENT ON COLUMN "public"."sys_permissions"."perm_type" IS '权限类型 (''MENU'', ''API'')';
COMMENT ON COLUMN "public"."sys_permissions"."parent_id" IS '父id';
COMMENT ON COLUMN "public"."sys_permissions"."component_path" IS '访问地址';
COMMENT ON COLUMN "public"."sys_permissions"."sort_order" IS '排序';
COMMENT ON COLUMN "public"."sys_permissions"."is_hidden" IS '是否隐藏';
COMMENT ON COLUMN "public"."sys_permissions"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_permissions"."updated_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_permissions"."allow_delete" IS '允许被删除 1 不允许 0 允许';

-- ----------------------------
-- Records of sys_permissions
-- ----------------------------
INSERT INTO "public"."sys_permissions" VALUES (12, 'menu:data:analysis:device', '设备数据分析', 'MENU', 10, '/data/analysis/device', 0, 'f', '2025-08-15 17:39:59', '2025-08-15 17:40:01', 0);
INSERT INTO "public"."sys_permissions" VALUES (17, 'func:menu:options', '权限编辑', 'API', 15, '/permission/**', 1, 'f', '2025-08-21 21:27:32', '2025-08-21 21:27:34', 1);
INSERT INTO "public"."sys_permissions" VALUES (14, 'menu:roles', '角色管理', 'MENU', 2, '/manage/roles', 4, 'f', '2025-08-21 20:36:36', '2025-08-21 20:36:38', 1);
INSERT INTO "public"."sys_permissions" VALUES (1968590841199058944, 'func:user:delete', '删除角色', 'API', 3, '/api/user/delete/**', 0, 'f', '2025-09-18 16:20:05.850834', '2025-09-18 16:20:11.361975', 0);
INSERT INTO "public"."sys_permissions" VALUES (1968591387989499904, 'func:user:list', '查看角色', 'API', 3, '', 0, 'f', '2025-09-18 16:22:16.214782', NULL, 0);
INSERT INTO "public"."sys_permissions" VALUES (8, 'menu:device_list', '设备列表', 'MENU', 7, '/device/list', 0, 'f', '2025-08-15 17:36:49', '2025-08-15 17:36:51', 1);
INSERT INTO "public"."sys_permissions" VALUES (9, 'menu:device_option', '设备控制', 'MENU', 7, '/device/option', 0, 'f', '2025-08-15 17:37:26', '2025-08-15 17:37:28', 1);
INSERT INTO "public"."sys_permissions" VALUES (13, 'menu:data:analysis:system', '系统设备数据分析', 'MENU', 10, '/data/analysis/system', 0, 'f', '2025-08-15 17:40:36.23945', '2025-08-15 17:40:36.23945', 1);
INSERT INTO "public"."sys_permissions" VALUES (11, 'menu:data:analysis:user', '用户数据分析', 'MENU', 10, '/data/analysis/user', 0, 'f', '2025-08-15 17:39:19', '2025-08-15 17:39:21', 1);
INSERT INTO "public"."sys_permissions" VALUES (1, 'menu:dashboard', '控制台', 'MENU', NULL, '/manage/dashboard', 0, 'f', '2025-08-11 14:53:34.638687', '2025-08-11 14:53:34.638687', 1);
INSERT INTO "public"."sys_permissions" VALUES (7, 'menu:device', '设备管理', 'MENU', NULL, '/system/device', 1, 'f', '2025-08-15 17:35:44', '2025-08-15 17:35:46', 1);
INSERT INTO "public"."sys_permissions" VALUES (10, 'menu:data_analysis', '数据分析', 'MENU', NULL, '/data/analysis', 2, 'f', '2025-08-15 17:38:30', '2025-08-15 17:38:32.185705', 1);
INSERT INTO "public"."sys_permissions" VALUES (2, 'menu:system', '系统管理', 'MENU', NULL, '/system', 3, 'f', '2025-08-11 14:53:34.638687', '2025-08-11 14:53:34.638687', 1);
INSERT INTO "public"."sys_permissions" VALUES (3, 'menu:system:user', '用户管理', 'MENU', 2, '/manage/users', 0, 'f', '2025-08-11 14:53:34.638687', '2025-08-24 15:52:15.150561', 1);
INSERT INTO "public"."sys_permissions" VALUES (15, 'menu:permissions', '菜单管理', 'MENU', 2, '/manage/menus', 5, 'f', '2025-08-21 20:37:24', '2025-08-21 20:37:26', 1);
INSERT INTO "public"."sys_permissions" VALUES (1967865595705745408, 'func:user:create:force', '用户管理创建用户', 'API', 3, '/login/register/force', 0, 'f', '2025-09-16 16:18:13.85115', NULL, 1);
INSERT INTO "public"."sys_permissions" VALUES (1967866294044778496, 'func:user:manager', '全局用户管理', 'API', 3, '/user/**', 0, 'f', '2025-09-16 16:21:00.346578', NULL, 0);
INSERT INTO "public"."sys_permissions" VALUES (1967866556847284224, 'func:role:manager:role', '全局角色管理', 'API', 14, '/role/**', 0, 'f', '2025-09-16 16:22:03.002811', NULL, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "id" int8 NOT NULL,
  "role_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_time" timestamp(6) NOT NULL,
  "updated_time" timestamp(6),
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "role_code" varchar(255) COLLATE "pg_catalog"."default" NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '角色名称';
COMMENT ON COLUMN "public"."sys_role"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_role"."updated_time" IS '更新时间';
COMMENT ON COLUMN "public"."sys_role"."description" IS '描述信息';
COMMENT ON COLUMN "public"."sys_role"."role_code" IS '角色编码';
COMMENT ON TABLE "public"."sys_role" IS '角色表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "public"."sys_role" VALUES (2, '设备管理员', '2025-08-10 14:57:06', '2025-09-12 17:05:42.205597', '设备权限', 'device');
INSERT INTO "public"."sys_role" VALUES (1, '超级管理员', '2025-08-10 14:56:52', '2025-09-18 15:43:27.027387', '超级管理员权限，允许控制所有的', 'admin');
INSERT INTO "public"."sys_role" VALUES (3, '普通用户', '2025-08-10 14:57:16', '2025-09-18 16:51:48.371966', '普通权限', 'personal');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_permission";
CREATE TABLE "public"."sys_role_permission" (
  "id" int8 NOT NULL,
  "role_id" int8 NOT NULL,
  "permission_id" int8 NOT NULL,
  "created_time" timestamp(6) NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_permission"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_role_permission"."role_id" IS '角色id';
COMMENT ON COLUMN "public"."sys_role_permission"."permission_id" IS '功能id';
COMMENT ON COLUMN "public"."sys_role_permission"."created_time" IS '添加时间';
COMMENT ON TABLE "public"."sys_role_permission" IS '角色和功能关联表';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584896, 1, 1968581562760986624, '2025-09-18 15:43:27.043021');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584897, 1, 1, '2025-09-18 15:43:27.044787');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584898, 1, 7, '2025-09-18 15:43:27.044787');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584899, 1, 8, '2025-09-18 15:43:27.044787');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584900, 1, 9, '2025-09-18 15:43:27.044787');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584901, 1, 10, '2025-09-18 15:43:27.045795');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584902, 1, 12, '2025-09-18 15:43:27.045795');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584903, 1, 13, '2025-09-18 15:43:27.045795');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584904, 1, 11, '2025-09-18 15:43:27.045795');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584905, 1, 2, '2025-09-18 15:43:27.045795');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584906, 1, 3, '2025-09-18 15:43:27.046794');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584907, 1, 1967865595705745408, '2025-09-18 15:43:27.046794');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584908, 1, 1967866294044778496, '2025-09-18 15:43:27.046794');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584909, 1, 14, '2025-09-18 15:43:27.046794');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584910, 1, 1967866556847284224, '2025-09-18 15:43:27.0478');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584911, 1, 15, '2025-09-18 15:43:27.0478');
INSERT INTO "public"."sys_role_permission" VALUES (1968581618725584912, 1, 17, '2025-09-18 15:43:27.0478');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256576, 2, 1, '2025-09-12 17:05:42.210594');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256577, 2, 7, '2025-09-12 17:05:42.210594');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256578, 2, 8, '2025-09-12 17:05:42.211592');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256579, 2, 9, '2025-09-12 17:05:42.211592');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256580, 2, 15, '2025-09-12 17:05:42.211592');
INSERT INTO "public"."sys_role_permission" VALUES (1966427991135256581, 2, 17, '2025-09-12 17:05:42.211592');
INSERT INTO "public"."sys_role_permission" VALUES (1968598820983975936, 3, 1, '2025-09-18 16:51:48.378578');
INSERT INTO "public"."sys_role_permission" VALUES (1968598820983975937, 3, 1968590841199058944, '2025-09-18 16:51:48.378578');
INSERT INTO "public"."sys_role_permission" VALUES (1968598820983975938, 3, 1968591387989499904, '2025-09-18 16:51:48.378578');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "id" int8 NOT NULL,
  "sys_user_id" int8 NOT NULL,
  "sys_role_id" int8 NOT NULL,
  "created_time" timestamp(6) NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_role"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_user_role"."sys_user_id" IS '用户id';
COMMENT ON COLUMN "public"."sys_user_role"."sys_role_id" IS '角色id';
COMMENT ON COLUMN "public"."sys_user_role"."created_time" IS '创建时间';
COMMENT ON TABLE "public"."sys_user_role" IS '用户角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "public"."sys_user_role" VALUES (2, 1954429745559031808, 2, '2025-08-10 14:59:18');
INSERT INTO "public"."sys_user_role" VALUES (1968588959135055872, 1952285877187211264, 3, '2025-09-18 16:12:37.130446');
INSERT INTO "public"."sys_user_role" VALUES (1968591039971319808, 1, 2, '2025-09-18 16:20:53.245249');
INSERT INTO "public"."sys_user_role" VALUES (1968591039971319809, 1, 1, '2025-09-18 16:20:53.247253');
INSERT INTO "public"."sys_user_role" VALUES (1968591039971319810, 1, 3, '2025-09-18 16:20:53.248255');

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_users";
CREATE TABLE "public"."sys_users" (
  "id" int8 NOT NULL,
  "user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(65535) COLLATE "pg_catalog"."default" NOT NULL,
  "nick_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "phone_number" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "sex" int2 NOT NULL,
  "avatar_url" varchar(255) COLLATE "pg_catalog"."default",
  "is_active" bool NOT NULL DEFAULT true,
  "last_login" timestamp(6) NOT NULL,
  "created_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_time" timestamp(6) DEFAULT CURRENT_TIMESTAMP
)
;
COMMENT ON COLUMN "public"."sys_users"."id" IS 'id';
COMMENT ON COLUMN "public"."sys_users"."user_name" IS '用户名称';
COMMENT ON COLUMN "public"."sys_users"."email" IS '邮箱';
COMMENT ON COLUMN "public"."sys_users"."password" IS '密码';
COMMENT ON COLUMN "public"."sys_users"."nick_name" IS '名称';
COMMENT ON COLUMN "public"."sys_users"."phone_number" IS '电话号码';
COMMENT ON COLUMN "public"."sys_users"."sex" IS '性别1 男 0 女';
COMMENT ON COLUMN "public"."sys_users"."avatar_url" IS '头像';
COMMENT ON COLUMN "public"."sys_users"."is_active" IS '是否允许使用';
COMMENT ON COLUMN "public"."sys_users"."last_login" IS '最后一次登录时间';
COMMENT ON COLUMN "public"."sys_users"."created_time" IS '创建时间';
COMMENT ON COLUMN "public"."sys_users"."updated_time" IS '更新时间';
COMMENT ON TABLE "public"."sys_users" IS '用户信息表';

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO "public"."sys_users" VALUES (1, 'admin', '17360402335@163.com', 'naVXh1afDqbE2RISMBFJUWld+Qcse/Wh72mfcVWFWPZUKlIoaZMW5m1ttVnLi6V02fHXIJVgwWWKSMsEDiy7GiPFlh5suKTCfbjxRhc8DzK5p0FitrWWuw7whfYxBtnvHf6BR4Gn+ZrSCKIE2Hh25LiDvMwHc3dkuTtDZf0veRLUN9ICQn5DJQhKYdR/6rN2+raavJvPVEyv7Cpl/yATkuV2SOBC6w0rkrBEQhXwzBsLLBK6oWwh+MJH891yeou8dkl8k9DuDZswQO9A6vfcz+5CLXQ8NoiWcymzUrbIPyfnCZsJdhrS8YA5MzpAeiALQyl1vmlo3pcPR0o701GYLLwWm732yFXN988F8yJCnxjo6pAAhnQLHD5sKY9BHPp5HLtKUIQP8/HfEp5vEmYPVPuWhUXVNcQtOGaufWz8JNpIGChW9pg3QLHG59WnV+p/kvyVgkZek7/GjeACdb5/PQk3BmiaCtfQKBfqTCb3rvlVlhqWZb0f3KAV4eGn6IqserRIcXI6xDICcC8urFc+MfZXMhSBTqYdlW5mMsQZJywgQFpDDmYdr+X06dl6lNMpSNknOyCM+JSeHhKt5lZbD+JFvDOZgi84kGVMvenReiheUrIwu2sFQsCQAJRY+qTaYroWNxZeRs+Ek3A1KxvP4+naW/0IBWtE3y7Do3bwsxd0tGY5Myajiew6a8ATdqxkOFhAmsmdEAflOjuJ/newYgSPVvX80fpiZsAGGrTFU5s0f/HzHsrSq3gJDYOKJLjqUGEg59E7DSlfFmKVtE1Uq22qbW0QaCJzv3+HORYl3duqaiLh0NuokZrGQYoKgZSLoHF3jlsOqBZfy6OVG0TMKaJ59rGvjWDzD2S6GZKBURhMO9UDTgBCRbUjUXSVFB8jxR1R/BQUjYti/ODOkh+ItR9E9B/b+n84S+XwQjee+Hb5Z8/MdbWfzu0Lw1ppOdrOcYBto+a1W6uQzU4n00YiwQWsPGr3gHq5Z+KQjCXD669obBVqwKxC223X+P7qIsvJUPSxxYZnl2HeHt6odsapKuJ0owWQYQN68SWC+4wJjbRKnP21Pr8MTnpcyfgQhV0T7u3GdRKD1CtE8tQngrgxK4jeTVGXJcFbue2NUO1m+OHPWFQArK4qTOPE/43WBOG39BScQkNA6bhf1E81MXIFGfzhIPptqvcsirqdFHiQYyIbZ6vvistK/ee09qRSmXyVf69vQUDpyvTHtGtJhdR9wvfPfUH9g6kcENijWKRjBdhao6F0rFeEipUw1r4ISfOd5yTldVuEM49Y5sXkeOyz49peUkdvqNZ0nELHT4JPFEUW/l1Ez0P1MxECcANOGXP6GdZSB9bUDYeedbnZ2TbDqL9UTNx5iq5azMORDgQvyDl3YqjkVHauTqmT3aB5F05G67DPxfvXaRV6qbvJ5T3yMQR6qU9eBxCdrMxakqT88chwDWyJgF6uBk4BWszQQF9Uk+Xv7xbD26yfm481k62R7Nt3FULYR+FQ1oWLkVfizjXJ5FLFSofnKih+9WqM+d8a5kAjWxHrxbbZtlzdsXgk/8838h0QWjC3ubXus/3DqKq+R9tnJh2o12yOVzIrrcXzhY6Ce1Rhn5yN5deexfA6XUFD5aTcjw76XQvEoCNxA+67LbreAXTg7jHc17FS9zCPNF/hWcKt5/Io/xY4ulF9L9tI57O/dTzuW5aclDgFNwY=', 'ck', '17360402335', 1, 'https://admcc.cn/marker.png', 't', '2025-09-18 16:02:53.960246', '2025-06-15 18:23:28', '2025-06-15 18:23:30');
INSERT INTO "public"."sys_users" VALUES (1952285877187211264, '2019031170', '1049835177@qq.com', 'av+PMCo2RqJMPXDPZ6AQh9ivcTO9tVc+LEenzMBh3nl6tmtz/3Z79ihnaPQNbhy0xxgl/R321Uv7QDkSwFbq4Sw7BtXMrhj+olwsWnaXaTJN5X19tM78Jgbz07zDB1p8tSt3QSlw2VdgS4yzwnlV1VJx0lJ/BLCc4c0YFQI7pkB1zYHcBI2r/lQX8opgtkYUa9cUdCwmXZR2BTOMlny0cR3OBXWZVfwbaJ2iUjmNnTBA+ub/uJty41eVtb/XpcY4vo1iPPxHJxO32rs2xmxXen3winLKbyrynv3AnmhSFsMh+yCn5oQ0p+W25hRuV9OxHfeVDT7ACZToJsiqKZPqf9LE1WNEVVDimTUWUq+YLGEomvdgWtuHi8WE48YZFWC2iEjlmuokicQd8mjSK0N2tvbCknUNOwLEahCAy1Fns/p29BF07e5bIix3qbTqoYPlarnx9k9Czw9DfnfwN2dgOy9ZN0BqFUgJgMZw5nD54OuBmw5mA7wQh6wnxKSXEeSNdjJ1vtnmOZx9082qM+alLIZsojdrCzZtv6loniFDiyQGvz4owyaPi6LisL5rwWAn1pLjmt0WFdqmSJdUHfk6ilhZjqsBO1Uq3oOpdxeRSK98wTyOUWeC+9ApGCVZYjq3sWAIXEQKPBXFHF6j9S1cBhOAJoOs3BaPoo+gkKRS2CfC0+ZJXpAJfDAVZNoL9fMzsMJNPLOa/yd+1yAuOgSBViA0FqWcNcU0Z6KFGQGVT/BFBKJWJGhrmPGhc+s0o1WsWYg4DjpXs+SK2flf08hIgM94wxKAvZnjwfXFfO8GLPkBZ9T1PY8sSE61wkOfCIF4Kubx4oEM/dDlAVaOwXo3RR79aD1YpBPT4gi4s0sfbetQMHtlnH5UiJKmjreEhD1zSzNkuStKbKDXNddyqBjDrA63xCAPPsUjup8s4+5RyYSfa5GuclmoTLXmLAlu7QsrRu4enC1I/LzLDGIOpiMnMnBxzM8InzjWE7SKeLrDmXegC+UZ2XYDaWwSuCv1/+AoqpDf4lNj+xsxpYD2XgghHJ1O6VNcyeLF/Z9EhQ7vogmQUhYDk3JsNJVVfr64n/zDUz70eFtTMuba8o3G1vSK06FcD1oBYjHj2MzO8/zixTvyPpj9tjwdvunuX4TH/F5wAphHVEGaMxHnQQlyBJixnlhWC5cnDJ3hFN6EviFXn8rzaEkc/pacKhHUDt5d5XOzOug2UmA/XJGOIxLQqJgUleLsJUbXcO0kl29N4Yuc65IekXjTiH2/k3jTucVwKH4OA61Qs7exHrhhBvy1BXAY8uKK0+f1sw1PJOU3pnayKuMV7cDKaI+fpzMXWhXKIubp0zmUGRis2ycFWFqN9Hz2gMfCxzDZuHT4JNk0R6O3wo6MW1bmF6XUwOIlNsCYAQTh+YVuGthbEG6H121Zv2kuNKyXwVkUMmvMLui2ygKc/AU2ROl8ynZXNk3srC0q5ou7i0NDTxp6S0UBjX74ND8nKQ46W6yPPKjKWlyjVMb6haoADC7HH1Eyfia6u10tB7/YmEeTEyU3qT9Fcsh2f6iQtuC/fyrGGA6xOFBEzr/TaZQJKrNyQ0RkZ6UzkpESYpo8J7k72P8jeA1SxHpnw7b1EfmVQbJu23rOAqvkBnNXoeS2Lvgmwbghkh3O7bFOuF18DcfehxYBigaH6a1TXRPBRBZ0JJFgBF8Ntt570bMKtjw=', 'kk', '17360402334', 1, 'https://admcc.cn/marker.png', 't', '2025-09-18 16:49:35.590302', '2025-08-04 16:29:59.52854', '2025-08-05 14:23:46.163415');
INSERT INTO "public"."sys_users" VALUES (1954429745559031808, '17341570037', '17341570037@163.com', 'vridF4ytdeeijYo/2/gXwWnU5W6z7x+EIE3WTCQcyHme0d9GyuWm/Eqmafgo/JEpuUqtxGFyurOTumh0ik/gFI01rMl4h+OESZiPhzoeBtbyeH1eWdjxkZY/vRf3Vq2waUabp3YYvaX/KLTb+UOJKSevBuAOcT692eNE7jbKrOMqdAsCZihoHVzY0yUMDSJtOzSj1jai+nbxVLcIunFsGk1w3JB5J5PApTTIkt7O9J5fZNr49YEeCNLECgpjYhkDF8oiOWHpa3Y3Spm0nVMOaFGXuJUMOLG564xIBoXd4N8DaEfTTh291EXvD5KJlSBjb8y5uipJex4VJbO6ugWwk/2LwOTfETy/fzl3SgC//bH1bRQN46N/0wmI91VUQfOlAkPjIS06/tzXt6lC3HrhAHja3yhFD+qDsCisKZz5z4MKO2zY8BjaKNME1HKbOqoXdvGmi/V9aNRcMVKOC7jihoKyBO23ofJl2xLxCg9FXfio3xuZHKJAtXr01nQmCVDylXACYfLMLr++nyaNEQsr3HN57iAHPfA1m3xHm0eBF7sK3DbNjGi1b6Viubkh7DvLMxXxc6dcuF4ZU0fE88fr+3Ay/Vm51ipqO08gDCtehHr942eXJT8n9QI/yRaUsJIDw7CgqLjr/5r6n5rHVgVi9jHaJoOmtQgnzrs4Bm2WsoF4vV94gzYPNHFimEBsIy+pwostqO5JmfD/3PhPzdAPw2yj0XgcYSeP5b1SRJe+7rsC1kr54W3L5nvFlPXmrooAGu/k4v8qDcpWe+nCbhqLsND4S+hiltR6cKDY4RiQL9kQRFaEYa92+aaxS2oWqzDb8tyW07BDUHoTkv0ck8+x2Zs/v2i5zANskJYdwhGTtbE573PYQqE62NW1B3fkcIdhO2t/6r6Os4imsUNC4Ur73R0nX3F2yrdZgiGs00GdjkAaLoEUUden18FCLzU5tN2miuqVVvWwKgTsxvdHBAbWf2+/7Ao6Pz6XoXvvK+grEHMaCAov0YDagHlQHSNPgS+hseecbioW/loNf+c0kuQN6OAysTMFSgo+HELr5tGMqT8Jm7cevFnN4h2fySCjXq5Ex9qbPcjKhwlq6GSrTN/2tG3ZRTPy98tbx44O7dKCbw3/GeerJbMe32IQpqX5aEH2SZa0RvI8qWZ0iolw/JzTWwMOqo9/+Gn+Ohu59FQoYJ8WbDjqD+/GNMb5jhuCaJSaKLym7C9SGlB/OrIUw2aAROZ3rHS7ODihqi52X3tztGMKClJ75MdwhrbY1iC2ge7l+p1ZullRR1CyUZxEIn2WF0LVm01ltf60drFuD8uLwI1QdAqPWFZCQmgBl2ucBE2bs1e+TE8camFHTuoDok+WWZ6P8ummUH143Qve5Dk7n70bq25JhsPFuzXN/01hx91ZlazyiUe224zw7/1LfoeGavB+1wnnI0k5eqZToXmllg6tQhYXeFBQu07xuSomJhyiXYl/N+5W8sa3XWI1pqVSXONTpZlZivoaenQ7RBO/ZxPLvIK/B1MdezV+mia7gUrkfoPDGwlxlhyqAhq2J0IVzsfMLGLFcjb+R6U9Te4Xa26F4MrlX6Ab0M0CghvAJAzA53xIZ2Yqrl29azs9w8VS5Kuml+r1wxbuYHB3RBm1LS6VNhboyXyMQRAVPMwpWCDA0uol7BrNtrZVSWKYzdOO1ZgjkNYFyEE0Tj+wDtMzkpQ=', 'zhangsanA', '17341570037', 1, 'https://admcc.cn/marker.png', 't', '2025-08-10 14:28:57.547037', '2025-08-10 14:28:57.678699', NULL);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."permissions_permission_id_seq"
OWNED BY "public"."sys_permissions"."permission_id";
SELECT setval('"public"."permissions_permission_id_seq"', 6, true);

-- ----------------------------
-- Primary Key structure for table device_gga_data
-- ----------------------------
ALTER TABLE "public"."device_gga_data" ADD CONSTRAINT "device_gga_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_gll_data
-- ----------------------------
ALTER TABLE "public"."device_gll_data" ADD CONSTRAINT "device_gll_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_gsa_data
-- ----------------------------
ALTER TABLE "public"."device_gsa_data" ADD CONSTRAINT "device_gsa_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_gsv_data
-- ----------------------------
ALTER TABLE "public"."device_gsv_data" ADD CONSTRAINT "device_gsv_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_gsv_satellite_data
-- ----------------------------
ALTER TABLE "public"."device_gsv_satellite_data" ADD CONSTRAINT "device_gsv_satellite_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_info
-- ----------------------------
ALTER TABLE "public"."device_info" ADD CONSTRAINT "device_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_rmc_data
-- ----------------------------
ALTER TABLE "public"."device_rmc_data" ADD CONSTRAINT "device_rmc_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_temp_data
-- ----------------------------
ALTER TABLE "public"."device_temp_data" ADD CONSTRAINT "device_temp_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_txt_data
-- ----------------------------
ALTER TABLE "public"."device_txt_data" ADD CONSTRAINT "device_gps_txt_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table device_vtg_data
-- ----------------------------
ALTER TABLE "public"."device_vtg_data" ADD CONSTRAINT "device_vtg_data_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Checks structure for table sys_permissions
-- ----------------------------
ALTER TABLE "public"."sys_permissions" ADD CONSTRAINT "permissions_perm_type_check" CHECK (perm_type::text = ANY (ARRAY['MENU'::character varying, 'BUTTON'::character varying, 'API'::character varying, 'DATA'::character varying]::text[]));

-- ----------------------------
-- Primary Key structure for table sys_permissions
-- ----------------------------
ALTER TABLE "public"."sys_permissions" ADD CONSTRAINT "permissions_pkey" PRIMARY KEY ("permission_id");

-- ----------------------------
-- Uniques structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "角色编码" UNIQUE ("role_code");
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "角色名称" UNIQUE ("role_name");
COMMENT ON CONSTRAINT "角色编码" ON "public"."sys_role" IS '唯一编码';
COMMENT ON CONSTRAINT "角色名称" ON "public"."sys_role" IS '唯一名称';

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sys_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role_permission
-- ----------------------------
ALTER TABLE "public"."sys_role_permission" ADD CONSTRAINT "sys_role_fun_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_users
-- ----------------------------
CREATE INDEX "idx_users_email" ON "public"."sys_users" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_is_active" ON "public"."sys_users" USING btree (
  "is_active" "pg_catalog"."bool_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_phone" ON "public"."sys_users" USING btree (
  "phone_number" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);
CREATE INDEX "idx_users_username" ON "public"."sys_users" USING btree (
  "user_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table sys_users
-- ----------------------------
ALTER TABLE "public"."sys_users" ADD CONSTRAINT "users_username_key" UNIQUE ("user_name");
ALTER TABLE "public"."sys_users" ADD CONSTRAINT "users_email_key" UNIQUE ("email");
ALTER TABLE "public"."sys_users" ADD CONSTRAINT "users_phone_number_key" UNIQUE ("phone_number");

-- ----------------------------
-- Primary Key structure for table sys_users
-- ----------------------------
ALTER TABLE "public"."sys_users" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
