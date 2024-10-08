-- include "lx_rs16_2d_outdoor.lua"

include "medical.lua"

TRAJECTORY_BUILDER.pure_localization_trimmer = {
    max_submaps_to_keep = 3,
}
POSE_GRAPH.optimize_every_n_nodes = 20

-- -- 表示是否使用imu数据，如果有就设置为true，如果imu特别差，就设置为false就行
-- TRAJECTORY_BUILDER_2D.use_imu_data=false

return options
