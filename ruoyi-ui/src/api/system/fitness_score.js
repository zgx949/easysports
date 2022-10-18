import request from '@/utils/request'

// 查询体测成绩列表
export function listFitness_score(query) {
  return request({
    url: '/system/fitness_score/list',
    method: 'get',
    params: query
  })
}

// 查询体测成绩详细
export function getFitness_score(id) {
  return request({
    url: '/system/fitness_score/' + id,
    method: 'get'
  })
}

// 新增体测成绩
export function addFitness_score(data) {
  return request({
    url: '/system/fitness_score',
    method: 'post',
    data: data
  })
}

// 修改体测成绩
export function updateFitness_score(data) {
  return request({
    url: '/system/fitness_score',
    method: 'put',
    data: data
  })
}

// 删除体测成绩
export function delFitness_score(id) {
  return request({
    url: '/system/fitness_score/' + id,
    method: 'delete'
  })
}
