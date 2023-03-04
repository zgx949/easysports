import upload from '@/utils/upload'
import request from '@/utils/request'


// 查询历史成绩记录
export function getMyFitnessTestGrade() {
  return request({
    url: '/system/grade/record',
    method: 'get'
  })
}
