import request from '@/utils/request'

// 查询用户信息列表
export function listFitness_info(query) {
  return request({
    url: '/system/fitness_info/list',
    method: 'get',
    params: query
  })
}

// 查询用户信息详细
export function getFitness_info(id) {
  return request({
    url: '/system/fitness_info/' + id,
    method: 'get'
  })
}

// 新增用户信息
export function addFitness_info(data) {
  return request({
    url: '/system/fitness_info',
    method: 'post',
    data: data
  })
}

// 修改用户信息
export function updateFitness_info(data) {
  return request({
    url: '/system/fitness_info',
    method: 'put',
    data: data
  })
}

// 删除用户信息
export function delFitness_info(id) {
  return request({
    url: '/system/fitness_info/' + id,
    method: 'delete'
  })
}
