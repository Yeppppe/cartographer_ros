-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
--   tracking_frame = "base_link",  要设置为imu_link
  tracking_frame = "imu_link",   
--   published_frame = "base_link", 
  published_frame = "odom", 
  odom_frame = "odom",
--   provide_odom_frame表示是否提供历程计 如果bag中有历程计坐标系就是false，如果没有则根据需要决定是否提供历程计坐标系，对于纯建图来讲，有没有每区别
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
-- use_pose_extrapolator不论什么时候都一定是false
  use_pose_extrapolator = false,
--   决定是否使用里程计的传感器数据，如果为true，则tf树中一定要存在odom这个坐标系
  use_odometry = false,
--   是否使用gps数据，如果为true就会订阅使用GPS数据
  use_nav_sat = false,
  use_landmarks = false,

--   num_laser_scans表示订阅单线点云数据，num_point_clouds表示订阅多线点云数据，同时为1表示既订阅单线又订阅点云
  num_laser_scans = 0,
--   num_multi_echo_laser_scans表示多回声雷达很少会用到因此为0
  num_multi_echo_laser_scans = 0,
--   num_subdivisions_per_laser_scan默认为1即可
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,

  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
-- 表示是否使用imu数据，如果有就设置为true，如果imu特别差，就设置为false就行
TRAJECTORY_BUILDER_2D.use_imu_data=true
-- 设置最小的点云的z轴的值，如果雷达数据比设置的z小，就要舍去（对于单线点云不能设置为大于0的值，也就是不设置，多线点云这个数值要大于0，不然建图就会建出一圈一圈的地面点，使得地图无法使用）
-- 所以当同时使用地面和多线的时候，这个min_z就有待考量，如果min_z大于0的话就会使得单线数据消失
TRAJECTORY_BUILDER_2D.min_z=0.2
-- TRAJECTORY_BUILDER_2D.num_accumulated_range_data = 10 这行代码不见了 很奇怪

return options
