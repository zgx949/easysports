import request from '@/utils/request'

// 查询号码段管理列表
export function listNums(query) {
  return request({
    url: '/system/nums/list',
    method: 'get',
    params: query
  })
}

// 查询号码段管理详细
export function getNums(id) {
  return request({
    url: '/system/nums/' + id,
    method: 'get'
  })
}

// 新增号码段管理
export function addNums(data) {
  return request({
    url: '/system/nums',
    method: 'post',
    data: data
  })
}

// 修改号码段管理
export function updateNums(data) {
  return request({
    url: '/system/nums',
    method: 'put',
    data: data
  })
}

// 删除号码段管理
export function delNums(id) {
  return request({
    url: '/system/nums/' + id,
    method: 'delete'
  })
}
