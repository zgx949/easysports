import request from '@/utils/request'

// 查询体测字典
export function activityDict() {
  return request({
    url: '/system/activity/dict',
    method: 'get'
  })
}

// 查询体测列表
export function listActivity(query) {
  return request({
    url: '/system/activity/list',
    method: 'get',
    params: query
  })
}

// 查询体测详细
export function getActivity(id) {
  return request({
    url: '/system/activity/' + id,
    method: 'get'
  })
}

// 新增体测
export function addActivity(data) {
  return request({
    url: '/system/activity',
    method: 'post',
    data: data
  })
}

// 修改体测
export function updateActivity(data) {
  return request({
    url: '/system/activity',
    method: 'put',
    data: data
  })
}

// 删除体测
export function delActivity(id) {
  return request({
    url: '/system/activity/' + id,
    method: 'delete'
  })
}
