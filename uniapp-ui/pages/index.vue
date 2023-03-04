<template>
	<view class="index-box">
		<view class="content">
			<!-- <image class="logo" src="/static/logo.png"></image> -->
			<image class="bg" src="https://img1.dowebok.com/2157.png"></image>
			<view class="text-area">
				<text class="title">EasySports</text>
			</view>
		</view>
		<view class="items" v-for="(item, index) in notics" :key="index">
			<uni-section :title="item.createTime" type="line">
				<uni-group mode="card">
					<h2 style="text-align: center; padding: 1rem;">{{ item.noticeTitle }}</h2>
					<u-read-more ref="uReadMore" :toggle="true" showHeight="50">
						<u-parse :content="item.noticeContent" @load="load">
						</u-parse>
					</u-read-more>
				</uni-group>
			</uni-section>

		</view>
		<u-loadmore :status="more" />
	</view>

</template>

<script>
	import {
		getNotic
	} from '@/api/system/notic.js'
	export default {
		data() {
			return {
				page: 1,
				pageSize: 10,
				total: undefined,
				notics: [],
				more: 'noMore',
			}
		},
		onReachBottom() {
			if (this.notics.length >= this.total) {
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
		onLoad: function() {
			this.notics = []
			this.getData();
		},
		onPullDownRefresh() {
			this.notics = []
			this.getData();
		},
		onShow() { //没次回到页面都会调用下拉刷新
			this.notics = []
			this.getData();
		},

		methods: {
			/** 获取文章数据 */
			getData() {
				uni.showLoading();
				getNotic(this.page, this.pageSize).then(res => {
					this.total = res.total;
					if (this.notics.length >= this.total) {
						return;
					}
					res.rows.forEach(i => {
						this.notics.push(i);
					})
					uni.hideLoading();
				})
			},
			load() {
				// this.$refs.uReadMore.init();
			}
		}
	}
</script>

<style scope>
	.bg {
		width: 100%;
		height: 400rpx;
	}

	.content {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}

	.logo {
		height: 200rpx;
		width: 200rpx;
		margin-top: 200rpx;
		margin-left: auto;
		margin-right: auto;
		margin-bottom: 50rpx;
	}

	.text-area {
		display: flex;
		justify-content: center;
	}

	.title {
		font-size: 36rpx;
		color: #8f8f94;
	}
</style>
