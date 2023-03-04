import upload from '@/utils/upload'
import request from '@/utils/request'


// 查询体测活动
export function getFitnessTestActivities() {
  return request({
    url: '/system/activity/list',
    method: 'get'
  })
}

// 查询已报名的活动
export const querySignedAct = () => {
	return request({
	  url: '/system/activity/list',
	  method: 'get'
	})
}

// 获取二维码
export const getQrCode = () => {
	return request({
	  url: '/system/user/qrcode',
	  method: 'get'
	})
}
