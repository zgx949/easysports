import request from '@/utils/request'

// 查询场地字典
export function dictGames(query) {
  return request({
    url: '/system/games/dict',
    method: 'get',
    params: query
  })
}

// 查询比赛管理列表
export function listGames(query) {
  return request({
    url: '/system/games/list',
    method: 'get',
    params: query
  })
}

// 查询比赛管理详细
export function getGames(id) {
  return request({
    url: '/system/games/' + id,
    method: 'get'
  })
}

// 新增比赛管理
export function addGames(data) {
  return request({
    url: '/system/games',
    method: 'post',
    data: data
  })
}

// 修改比赛管理
export function updateGames(data) {
  return request({
    url: '/system/games',
    method: 'put',
    data: data
  })
}

// 删除比赛管理
export function delGames(id) {
  return request({
    url: '/system/games/' + id,
    method: 'delete'
  })
}
