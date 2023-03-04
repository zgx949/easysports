import upload from '@/utils/upload'
import request from '@/utils/request'

// 所有比赛的信息
export function queryGames(pageNum, pageSize) {
  return request({
    url: `/system/games/list?pageNum=${pageNum}&pageSize=${pageSize}`,
    method: 'get'
  })
}

// 用户报名比赛
export function registerGame(gameId) {
  return request({
    url: `/system/registrations/user/${gameId}`,
    method: 'post'
  })
}

// 用户取消报名比赛
export function cancelGame(gameId) {
  return request({
    url: `/system/registrations/user/${gameId}`,
    method: 'delete'
  })
}

// 查询比赛信息
export const queryGameById = (gameId) => {
	return request({
	  url: `/system/games/${gameId}`,
	  method: 'get'
	})
}