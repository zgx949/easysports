<template>
	<view>
		<!-- {{ itemType }}, {{objType}}, {{timeSortType}}, {{ genderType}} -->
		<view class="page page-index">
			<fy-dropdown :menuList="menuList">
				<fy-dropdown-item v-model="itemType" dropdownKey="itemType" :options="itemOptions"
					@change="handlerTypeChange"></fy-dropdown-item>
				<fy-dropdown-item v-model="genderType" dropdownKey="genderType" :options="genderOptions"
					@change="handlerTypeChange"></fy-dropdown-item>
				<fy-dropdown-item v-model="objType" dropdownKey="registerObj" :options="objOptions"
					@change="handlerTypeChange"></fy-dropdown-item>
				<fy-dropdown-item v-model="timeSortType" dropdownKey="timeSort" :options="timeSortOptions"
					@change="handlerTypeChange"></fy-dropdown-item>
			</fy-dropdown>
		</view>
		<view v-for="(item,index) in filteredGamesList" :key="index">

			<uni-card :title="item.gameName" :sub-title="'比赛时间:' + item.startTime" :extra="statusMap[item.status]"
				thumbnail="https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/460d46d0-4fcc-11eb-8ff1-d5dcf8779628.png">
				<text>{{ item.remark }}</text>
				<view class="card-actions-item">
					<!-- <text>{{ item.field === null ? '暂未分配场地' : item.field.name }}</text> -->
					<!-- <text class="game-desc">比赛的具体信息，包括比赛地点，性别限制，介绍信息等等</text> -->

					<view v-if="item.status === 0">
						<u-button type="primary" icon="plus" text="报名" @click="register(item.id)"></u-button>
					</view>
					<view v-else-if="item.status===1">
						<u-button type="primary" icon="plus" text="已截止" :disabled="true"></u-button>
					</view>
					<view v-else>
						<u-button type="primary" icon="plus" text="无法报名" :disabled="true"></u-button>
					</view>

				</view>
			</uni-card>


		</view>
		<u-loadmore :status="more" />
	</view>
</template>

<script>
	import {
		queryGames
	} from '@/api/sportmeeting/register.js'
	export default {
		computed: {
			// 过滤后的报名数据
			filteredGamesList() {
				let gameList = this.items.filter(item => {
					return (!this.itemType || item.item.type == this.itemType) && 
						(this.genderType===null || this.genderType==='' || item.gender === -1 || item.gender === this.genderType);
				})
				if (gameList.length === 0) {
					this.page++;
					this.getData();
				}
				return gameList;
			}
		},
		data() {
			return {
				statusMap: ['报名中', '准备中', '比赛中', '结束'],
				more: 'noMore',
				page: 1,
				pageSize: 100,
				items: [],
				total: undefined,
				// 筛选配置
				menuList: [
					{
						title: '比赛类型',
						dropdownKey: 'itemType'
					},{
						title: '性别',
						dropdownKey: 'genderType'
					}, {
						title: '报名对象',
						dropdownKey: 'registerObj'
					}, {
						title: '时间排序',
						dropdownKey: 'timeSort'
					}, 
				],
				synthesisValue: '',
				itemType: null,
				itemOptions: [
					{
						label: '所有',
						value: null
					},
					{
						label: '田赛',
						value: 1
					}, {
						label: '径赛',
						value: 2
					}, {
						label: '团体赛',
						value: 3
				}],
				objType: null,
				objOptions: [
					{
						label: '所有',
						value: null
					},
					{
						label: '学生',
						value: 1
					}, {
						label: '教师',
						value: 2
				}],
				timeSortType: '',
				timeSortOptions: [
					{
						label: '所有',
						value: null
					},
					{
						label: '最早在前',
						value: 1
					}, {
						label: '最晚在前',
						value: 2
				}],
				genderType: null,
				genderOptions: [
					{
						label: '所有',
						value: null
					},
					{
						label: '男',
						value: 0
					}, {
						label: '女',
						value: 1
				}, {
						label: '不限',
						value: -1
				}],
			}
		},
		onReachBottom() {
			if (this.items.length >= this.total) {
				uni.showToast({
					title: '没有更多的啦'
				});
				this.more = 'nomore';
				return;
			}
			this.more = 'loading';
			this.page++
			this.getData(); //执行的方法
			this.more = 'noMore'
		},
		methods: {
			register(id) {
				uni.navigateTo({
					url: '/pages/work/sportmeeting/games/register/register?gid=' + id,
					animationType: 'pop-in',
					animationDuration: 200
				})
			},
			getData() {
				uni.showLoading({
					title: '加载中'
				})
				queryGames(this.page, this.pageSize).then(res => {
					this.total = res.total
					if (this.items.length >= this.total) {

						return;
					}
					res.rows.forEach(i => {
						this.items.push(i);
					})
					uni.hideLoading()
				})
			},
			// 筛选
			handlerTypeChange(e) {
				console.log(e);
			},
		},
		mounted() {
			this.getData()
		}
	}
</script>

<style scope>
	.card-actions-item {
		padding: 1rem;

	}

	.game-desc {
		padding: 1rem;
	}
</style>
