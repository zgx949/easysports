import request from '@/utils/request'

// 查询可报名比赛字典
export function dictGamesRegister() {
  return request({
    url: '/system/games/register',
    method: 'get',
  })
}

// 查询比赛字典
export function dictGames() {
  return request({
    url: '/system/games/dict',
    method: 'get',
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

// 查询比赛获奖结果
export function getGameWinList(id) {
  return request({
    url: '/system/games/single/' + parseInt(id),
    method: 'get'
  })
}

// 根据比赛id查询待记录分数人员
export function getPlayerByGameId(pageData) {
  return request({
    url: '/system/games/insert/',
    method: 'get',
    params: pageData
  })
}
// 根据用户ID查询待记录分数比赛列表
export function searchGameListByUserId(pageData) {
  return request({
    url: '/system/games/search/',
    method: 'get',
    params: pageData
  })
}
// 录入比赛成绩
export function registerScore(data) {
  return request({
    url: '/system/registrations/update/score',
    method: 'put',
    data: data
  })
}

// 获取秩序册信息数据
export function getRosterInfo() {
  return request({
    url: '/system/registrations' ,
    method: 'get'
  })
}

// 查询需要决赛的比赛列表
export function getFinalGameList() {
  return request({
    url: 'system/games/promotion/list' ,
    method: 'get'
  })
}

// 根据项目ID查询决赛项目数据
export function getFinalGameDataById(gameId) {
  return request({
    url: 'system/games/promotion/'+gameId ,
    method: 'get'
  })
}

