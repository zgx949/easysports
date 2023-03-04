import upload from '@/utils/upload'
import request from '@/utils/request'


// 查询用户报名的比赛
export function getMyGames() {
  return request({
    url: '/system/registrations/user/list',
    method: 'get'
  })
}

// 用户查询具体某个比赛的情况
export const getMyGameBygameId = (gameId) => {
	return request({
	  url: `/system/registrations/user/${gameId}`,
	  method: 'get'
	})
}


