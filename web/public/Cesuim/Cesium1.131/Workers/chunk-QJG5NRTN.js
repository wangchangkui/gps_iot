/**
 * @license
 * Cesium - https://github.com/CesiumGS/cesium
 * Version 1.131
 *
 * Copyright 2011-2022 Cesium Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Columbus View (Pat. Pend.)
 *
 * Portions licensed separately.
 * See https://github.com/CesiumGS/cesium/blob/main/LICENSE.md for full licensing details.
 */

import{a as u,b as c,d as p}from"./chunk-FCVV6A2F.js";import{a as d}from"./chunk-PO64KPKA.js";import{a as s}from"./chunk-R3KD5ZAI.js";import{e as a}from"./chunk-GBI3IATP.js";function e(t){this._ellipsoid=t??p.WGS84,this._semimajorAxis=this._ellipsoid.maximumRadius,this._oneOverSemimajorAxis=1/this._semimajorAxis}Object.defineProperties(e.prototype,{ellipsoid:{get:function(){return this._ellipsoid}}});e.mercatorAngleToGeodeticLatitude=function(t){return d.PI_OVER_TWO-2*Math.atan(Math.exp(-t))};e.geodeticLatitudeToMercatorAngle=function(t){t>e.MaximumLatitude?t=e.MaximumLatitude:t<-e.MaximumLatitude&&(t=-e.MaximumLatitude);let i=Math.sin(t);return .5*Math.log((1+i)/(1-i))};e.MaximumLatitude=e.mercatorAngleToGeodeticLatitude(Math.PI);e.prototype.project=function(t,i){let o=this._semimajorAxis,r=t.longitude*o,n=e.geodeticLatitudeToMercatorAngle(t.latitude)*o,m=t.height;return a(i)?(i.x=r,i.y=n,i.z=m,i):new u(r,n,m)};e.prototype.unproject=function(t,i){if(!a(t))throw new s("cartesian is required");let o=this._oneOverSemimajorAxis,r=t.x*o,n=e.mercatorAngleToGeodeticLatitude(t.y*o),m=t.z;return a(i)?(i.longitude=r,i.latitude=n,i.height=m,i):new c(r,n,m)};var A=e;export{A as a};
