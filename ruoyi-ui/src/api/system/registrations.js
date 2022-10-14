import request from '@/utils/request'

// 用户报名接口
export function userRegistrations(data) {
  return request({
    url: '/system/registrations',
    method: 'post',
    data: data
  })
}

// 查询报名管理列表
export function listRegistrations(query) {
  return request({
    url: '/system/registrations/list',
    method: 'get',
    params: query
  })
}

// 查询报名管理详细
export function getRegistrations(id) {
  return request({
    url: '/system/registrations/' + id,
    method: 'get'
  })
}

// 新增报名管理
export function addRegistrations(data) {
  return request({
    url: '/system/registrations',
    method: 'post',
    data: data
  })
}

// 修改报名管理
export function updateRegistrations(data) {
  return request({
    url: '/system/registrations',
    method: 'put',
    data: data
  })
}

// 删除报名管理
export function delRegistrations(id) {
  return request({
    url: '/system/registrations/' + id,
    method: 'delete'
  })
}
