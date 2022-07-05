import request from '@/utils/request'

// 查询场地字典
export function dictFields(query) {
  return request({
    url: '/system/fields/dict',
    method: 'get',
    params: query
  })
}

// 查询场地管理列表
export function listFields(query) {
  return request({
    url: '/system/fields/list',
    method: 'get',
    params: query
  })
}

// 查询场地管理详细
export function getFields(id) {
  return request({
    url: '/system/fields/' + id,
    method: 'get'
  })
}

// 新增场地管理
export function addFields(data) {
  return request({
    url: '/system/fields',
    method: 'post',
    data: data
  })
}

// 修改场地管理
export function updateFields(data) {
  return request({
    url: '/system/fields',
    method: 'put',
    data: data
  })
}

// 删除场地管理
export function delFields(id) {
  return request({
    url: '/system/fields/' + id,
    method: 'delete'
  })
}
