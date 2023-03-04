
import upload from '@/utils/upload'
import request from '@/utils/request'


// 查询通知
export function getNotic(page, pageSize) {
  return request({
    url: `/system/notice/list?pageNum=${page}&pageSize=${pageSize}`,
    method: 'get'
  })
}


