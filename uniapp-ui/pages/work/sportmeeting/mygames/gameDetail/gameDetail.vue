<template>
	<view>		
		<uni-card :title="data.game.gameName" :sub-title="data.game.createTime" :extra="''"
			thumbnail="https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/460d46d0-4fcc-11eb-8ff1-d5dcf8779628.png">
			<view class="card-actions-item">
				<u-cell icon="file-text" :title="'排名：' + rank "></u-cell>
			</view>
			<view class="card-actions-item">
				<u-cell icon="man-delete" :title="'姓名：' + data.user.nickName "></u-cell>
			</view>
			<view class="card-actions-item">
				<u-cell icon="woman" :title="'性别：' + (data.user.sex == '0' ? '男' : '女')"></u-cell>
			</view>
			<view class="card-actions-item">
				<u-cell icon="edit-pen" :title="'成绩：' + data.score "></u-cell>
			</view>
			<view class="card-actions-item">
				<u-cell icon="star" :title="'积分：' + data.points + '分' "></u-cell>
			</view>
			<view class="card-actions-item">
				<u-cell icon="chat" :title="'备注：' + data.remark"></u-cell>
			</view>
		</uni-card>
		<u-button type="primary" icon="arrow-left" @click="back" text="返回"></u-button>
	</view>
</template>

<script>
	import { getMyGameBygameId } from '@/api/sportmeeting/mygame.js'
	export default {
		data() {
			return {
				gid: null,
				data: {},
				rank: null,
			}
		},
		methods: {
			back () {
				uni.navigateBack({delta: 1});
			},
			gameData() {
				uni.showLoading({
					title: '加载中'
				})
				if (this.gid == null) return;
				getMyGameBygameId(this.gid).then(res => {
					if (res.code !== 200){
						uni.showToast({
							title: res.msg,
							icon: 'error'
						})
						this.back();
						return;
					}
					this.data = res.data.sportRegistrations;
					this.rank = res.data.userOrder;
					uni.hideLoading();
				});
			},
		},
		onLoad(params) {
			this.gid = params.gid;
			this.gameData();
		}
	}
</script>

<style>
.card-actions-item {
	padding: 0.5rem;
}
</style>
