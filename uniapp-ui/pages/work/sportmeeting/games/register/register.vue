<!-- 本示例未包含完整css，获取外链css请参考上文，在hello uni-app项目中查看 -->
<template>
	<view>

		<uni-card :title="item.gameName" :sub-title="item.field? item.field.name : '暂未分配场地'" :extra="statusMap[item.status]"
			thumbnail="https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/460d46d0-4fcc-11eb-8ff1-d5dcf8779628.png">
			<text>{{ item.remark }}</text>

			<uni-section title="比赛详细" type="line">
				<text class="game-desc">比赛的具体信息，包括比赛地点，性别限制，介绍信息等等</text>
				<u-cell size="small" title="性别限制:" :value="genderMap[item.gender]"></u-cell>
				<u-cell size="small" title="比赛类型:" :value="itemTypeMap[item.item.type]"></u-cell>
				<u-cell size="small" title="比赛时间:" :value="item.startTime"></u-cell>
				<u-cell size="small" title="比赛场地:" :value="item.field? item.field.name : '暂未分配场地'"></u-cell>
			</uni-section>

			<view class="card-actions-item">
				<uni-section title="个人信息" type="line">
					<u-cell size="small" title="姓名:" :value="userinfo.nickName"></u-cell>
					<u-cell size="small" title="学院:" :value="userinfo.dept.deptName"></u-cell>
					<u-cell size="small" title="负责人:" :value="userinfo.dept.leader"></u-cell>
				</uni-section>
				<uni-section title="报名材料上传(开发中)" type="line">
					<view class="uploader">
						<!-- <u-upload :fileList="fileList1" @afterRead="afterRead" @delete="deletePic" name="1" multiple
							:maxCount="10">
						</u-upload> -->
						<u-upload>
						</u-upload>
					</view>
				</uni-section>
				<view>
					<u-button v-if="item.gender == -1 || item.gender == userinfo.sex" type="primary" icon="plus" text="确认报名" @click="register(gid)"></u-button>
					<u-button v-else="item.gender == userinfo.sex" disabled type="primary" icon="plus" text="性别限制, 无法报名"></u-button>
				</view>
			</view>

		</uni-card>

	</view>
</template>


<script>
	import {
		queryGameById,
		registerGame
	} from '@/api/sportmeeting/register.js';
	import {
		getUserProfile
	} from '@/api/system/user.js';
	export default {
		data() {
			return {
				itemTypeMap: ['田赛', '径赛', '团体赛'],
				genderMap: ['男', '女', '不限'],
				statusMap: ['报名中', '准备中', '比赛中', '结束'],
				userinfo: {
					nickName: '',
					dept: {
						deptName: '',
						leader: ''
					}
				},
				// 比赛id
				gid: null,
				item: {

					"createTime": null,
					"updateBy": null,
					"updateTime": null,
					"remark": null,
					"id": null,
					"itemId": null,
					"gameName": null,
					"nextGame": null,
					"gender": null,
					"fieldId": null,
					"maxPerson": null,
					"status": null,
					"startTime": null,
					"endTime": null,
					"sportItemList": null,
					"field": {
						"parentName": null,
						"parentId": null,
						"orderNum": null,
						"ancestors": null,
						"children": [

						],
						"id": null,
						"name": null,
						"maxPerson": null
					},
					"game": null,
					"item": {
						"createTime": null,
						"updateBy": null,
						"updateTime": null,
						"remark": null,
						"id": null,
						"itemName": null,
						"maxPerson": null,
						"type": null,
						"unit": null,
						"isDesc": null
					}
				},
				rules: {},
			}
		},
		methods: {
			register(gid) {
				console.log('报名');
				uni.showLoading({
					title: '报名中'
				})

				registerGame(this.gid).then(res => {
					uni.hideLoading()
					// debugger
					uni.navigateTo({
						url: '/pages/work/sportmeeting/result/result?title=' +
							(res.code === 200 ? '报名成功' : res.msg) +
							'&subtitle=请联系管理员确保报名信息无误' +
							'&type=' + (res.code === 200 ? 'success' : 'error')
					})

				})

			}
		},
		onLoad(params) {
			
			this.gid = params.gid;
			uni.showLoading({
				title: '加载中'
			})
			queryGameById(this.gid).then(res => {
				if (res.code === 200) {
					this.item = res.data;
					uni.hideLoading();
				} else {
					uni.showToast({
						title: res.msg
					});
				}
				
			})
			// 获取用户信息
			getUserProfile().then(res => {
				if (res.code === 200) {
					this.userinfo = res.data
				} else {
					uni.showToast({
						title: res.msg,
						icon: 'error'
					})
				}
			})
		}
	}
</script>

<style scope>
	.uploader {
		padding: 1rem;
	}

	.item-text {
		padding: 0.5rem;
	}
</style>
