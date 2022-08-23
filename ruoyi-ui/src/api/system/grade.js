import request from '@/utils/request'

// 查询体测成绩列表
export function listGrade(query) {
  return request({
    url: '/system/grade/list',
    method: 'get',
    params: query
  })
}

// 查询体测成绩详细
export function getGrade(id) {
  return request({
    url: '/system/grade/' + id,
    method: 'get'
  })
}

// 新增体测成绩
export function addGrade(data) {
  return request({
    url: '/system/grade',
    method: 'post',
    data: data
  })
}

// 修改体测成绩
export function updateGrade(data) {
  return request({
    url: '/system/grade',
    method: 'put',
    data: data
  })
}

// 删除体测成绩
export function delGrade(id) {
  return request({
    url: '/system/grade/' + id,
    method: 'delete'
  })
}