<template>
	<view class="work-container">
		<!-- 轮播图 -->
		<uni-swiper-dot class="uni-swiper-dot-box" :info="data" :current="current" field="content">
			<swiper class="swiper-box" :current="swiperDotIndex" @change="changeSwiper">
				<swiper-item v-for="(item, index) in data" :key="index">
					<view class="swiper-item" @click="clickBannerItem(item)">
						<image :src="item.image" mode="aspectFill" :draggable="false" />
					</view>
				</swiper-item>
			</swiper>
		</uni-swiper-dot>
		<!-- 宫格组件 -->
		<view class="contents">
			<u-cell-group v-for="(item,index) in menuList" :key="index" :customStyle="customStyles"
				:title="item.menuName" :border="false">
				<view class="" style="padding: 0 20rpx;">
					<u-grid :border="false" @click="click" col="3">
						<u-grid-item v-for="(item2,index2) in item.childList" @click="navTo(item2.url)">
							<view class="grid-item" :style="{backgroundColor:item2.menuColor}" v-if="item2.adminApp == false || (item2.adminApp == true && roles == 'admin')">
								<view class="grid-item-image">
									<image :src="item2.menuIcon" mode="widthFix"></image>
								</view>
								<view class="grid-item-name">
									{{item2.menuName}}
								</view>
							</view>
						</u-grid-item>
					</u-grid>
				</view>
			</u-cell-group>
		</view>
	</view>
</template>

<script>
	import storage from '@/utils/storage.js';
	export default {
		data() {
			return {
				customStyles: {
					'fontWeight': 'bold'
				},
				roles: '',
				current: 0,
				swiperDotIndex: 0,
				data: [{
						image: '/static/images/banner/banner01.jpg'
					},
					{
						image: '/static/images/banner/banner02.jpg'
					},
					{
						image: '/static/images/banner/banner03.jpg'
					}
				],
				menuList: [{
					menuCode: 'a-2',
					menuName: '体测',
					menuIcon: 'file-text',
					menuColor: '#19be6b',
					url: '',
					childList: [{
							menuCode: 'a22',
							menuName: '体测报名',
							menuIcon: '/static/images/work/tj.png',
							menuColor: '#e2e8f4',
							url: '/pages/work/fitnesstest/activities/activities',
							adminApp: false,
						}, {
							menuCode: 'a23',
							menuName: '二维码验证',
							menuIcon: '/static/images/work/code.png',
							menuColor: '#f7eee7',
							url: '/pages/work/fitnesstest/verify/verify',
							adminApp: false,
						}, {
							menuCode: 'a24',
							menuName: '成绩查询',
							menuIcon: '/static/images/work/cj.png',
							menuColor: '#f4f4f4',
							url: '/pages/work/fitnesstest/score/score',
							adminApp: false,
						}, {
							menuCode: 'a25',
							menuName: '成绩录入',
							menuIcon: '/static/images/work/cj.png',
							menuColor: '#f4f4f4',
							url: '/pages/work/fitnesstest/scanf/scanf',
							adminApp: true,
						},

					]
				}, {
					menuCode: 'a-1',
					menuName: '运动会',
					menuIcon: 'file-text',
					menuColor: '#2979ff',
					url: '',
					childList: [{
							menuCode: 'a13',
							menuName: '所有赛事',
							menuIcon: '/static/images/work/sy.png',
							menuColor: '#edf9f8',
							url: '/pages/work/sportmeeting/games/games',
							adminApp: false,
						}, {
							menuCode: 'a10',
							menuName: '我的比赛',
							menuIcon: '/static/images/work/bs.png',
							menuColor: '#cbf4e6',
							url: '/pages/work/sportmeeting/mygames/mygames',
							adminApp: false,
						},
						// {
						// 	menuCode: 'a19',
						// 	menuName: '获奖公示',
						// 	menuIcon: 'bell',
						// 	menuColor: '#2979ff',
						// 	url: '/pages/oa/oaLeave/index',
						// },
						{
							menuCode: 'a12',
							menuName: '举报反馈',
							menuIcon: '/static/images/work/jb.png',
							menuColor: '#fdeede',
							url: '/pages/oa/oaLeave/index',
							adminApp: false,
						},
					]
				}],
			}
		},
		onLoad() {
			
			if (storage.get('vuex_roles')[0] == 'admin') {
				this.roles = 'admin';
			}
			console.log(this.roles);
		},
		methods: {
			clickBannerItem(item) {
				console.info(item)
			},
			changeSwiper(e) {
				this.current = e.detail.current
			},
			changeGrid(e) {
				this.$modal.showToast('模块建设中~')
			},
			navTo(url) {
				uni.navigateTo({
					url: url
				});
			},
		}
	}
</script>

<style lang="scss">
	.grid-item-image {
		width: 60rpx;
		height: 60rpx;
		
		image {
			width: 100%;
			height: 100%;
		}
	}

	.grid-item-name {
		margin-top: 20rpx;
	}

	.grid-item {
		margin-top: 20rpx;
		width: 200rpx;
		height: 200rpx;
		border-radius: 20rpx;
		background-color: #e5ebf7;
		display: flex;
		align-items: center;
		flex-direction: column;
		justify-content: center;
	}

	/* #ifndef APP-NVUE */
	page {

		display: flex;
		flex-direction: column;
		box-sizing: border-box;
		background-color: #fff;
		min-height: 100%;
		height: auto;
	}

	view {
		font-size: 14px;
		line-height: inherit;
	}

	/* #endif */

	.text {
		text-align: center;
		font-size: 26rpx;
		margin-top: 10rpx;
	}

	.grid-item-box {
		flex: 1;
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		align-items: center;
		justify-content: center;
		padding: 15px 0;
	}

	.uni-margin-wrap {
		width: 690rpx;
		width: 100%;
		;
	}

	.swiper {
		height: 300rpx;
	}

	.swiper-box {
		height: 150px;
	}

	.swiper-item {
		/* #ifndef APP-NVUE */
		display: flex;
		/* #endif */
		flex-direction: column;
		justify-content: center;
		align-items: center;
		color: #fff;
		height: 300rpx;
		line-height: 300rpx;
	}

	@media screen and (min-width: 500px) {
		.uni-swiper-dot-box {
			width: 400px;
			/* #ifndef APP-NVUE */
			margin: 0 auto;
			/* #endif */
			margin-top: 8px;
		}

		.image {
			width: 100%;
		}
	}

	.toolbar {
		padding-top: 5px;
		background-color: #fff;
	}

	.grid {

		.grid-icon {
			color: #666;
		}

		.grid-text {
			font-size: 32rpx;
			padding: 15rpx;
		}
	}

	// 复制部分
	.box {
		padding-bottom: 10rpx;

		.item {
			margin: 0 20rpx 20rpx;
			padding: 8rpx 20rpx;
			border-radius: 20rpx;
			box-sizing: border-box;
			background-color: #fff;
			font-size: 28rpx;

			.title {
				display: flex;
				justify-content: space-between;
				background-color: #fff;
				padding-left: 15rpx;
				align-items: center;
				align-self: flex-start;

				.text {
					margin: 0 20rpx;
					font-size: 35rpx;
					font-weight: bold;
				}

			}
		}

	}

	.grid-icon {
		color: #666;
	}

	.grid-text {
		font-size: 32rpx;
		padding: 15rpx;
	}
</style>
