<template>
	<view>
		<u-modal :show="show" @confirm="cancle(gid)" @cancel="show = false" ref="uModal" title="系统提示" content="是否取消报名？"
			confirmText="确定" cancelText="点错了" :showConfirmButton="true" :showCancelButton="true"></u-modal>
		<view v-if="dataList.length === 0">
			<u-empty mode="data" icon="http://cdn.uviewui.com/uview/empty/data.png">
			</u-empty>
		</view>
		<view v-else v-for="(data,index) in dataList" :key="index">
			<uni-card :title="data.sportRegistrations.game.gameName"
				:sub-title="data.sportRegistrations.game.createTime" :extra="''"
				thumbnail="https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/460d46d0-4fcc-11eb-8ff1-d5dcf8779628.png">
				<view class="operrations">
					<view class="itembutton" @click="toGetDesc(data.sportRegistrations.game.id)">
						<u-icon :size="30" :name="'order'"></u-icon>详情
					</view>
					<view class="itembutton" @click="()=>{gid = data.sportRegistrations.game.id; show = true}">
						<u-icon :size="30" :name="'trash'"></u-icon>取消
					</view>
					<view class="itembutton" @click="feedback">
						<u-icon :size="30" :name="'info'"></u-icon>反馈
					</view>
				</view>
				<view>
					<u-tag v-if="data.sportRegistrations.status == 1" class="game-status" text="审核通过" type="success">
					</u-tag>
					<u-tag v-else-if="data.sportRegistrations.status == 0" class="game-status" text="审核中"
						type="warning"></u-tag>
					<u-tag v-else class="game-status" text="审核未通过" type="error"></u-tag>
				</view>
				<view class="card-actions-item">
					<u-cell icon="file-text" :title="'排名：' + data.userOrder "></u-cell>
				</view>
				<view class="card-actions-item">
					<u-cell icon="man-delete" :title="'姓名：' + data.sportRegistrations.user.nickName "></u-cell>
				</view>
				<view class="card-actions-item">
					<u-cell icon="woman" :title="'性别：' + (data.sportRegistrations.user.sex == '0' ? '男' : '女')">
					</u-cell>
				</view>
				<view class="card-actions-item">
					<u-cell icon="edit-pen" :title="'成绩：' + data.sportRegistrations.score "></u-cell>
				</view>
				<view class="card-actions-item">
					<u-cell icon="star" :title="'积分：' + data.sportRegistrations.points + '分' "></u-cell>
				</view>
				<view class="card-actions-item">
					<u-cell icon="chat" :title="'备注：' + data.sportRegistrations.remark"></u-cell>
				</view>
			</uni-card>
			<!-- <uni-section :title="item.game.gameName" type="line">
				<uni-group mode="card">
					<view class="operrations">
						<view class="itembutton" @click="toGetDesc(item.game.id)">
							<u-icon :size="30" :name="'order'"></u-icon>详情
						</view>
						<view class="itembutton" @click="()=>{gid = item.game.id; show = true}">
							<u-icon :size="30" :name="'trash'"></u-icon>取消
						</view>
						<view class="itembutton" @click="feedback">
							<u-icon :size="30" :name="'info'"></u-icon>反馈
						</view>
					</view>
					<view>
						<u-tag v-if="item.status == 1" class="game-status" text="审核通过" type="success"></u-tag>
						<u-tag v-else-if="item.status == 0" class="game-status" text="审核中" type="warning"></u-tag>
						<u-tag v-else class="game-status" text="审核未通过" type="error"></u-tag>
					</view>
					<uni-table ref="table" border stripe emptyText="暂无更多数据">
						<uni-tr>
							<uni-th width="50" align="center">成绩({{ '单位' }})</uni-th>
							<!-- <uni-th width="50" align="center">得分</uni-th> -->
			<!-- <uni-th width="50" align="center">积分</uni-th>
							<uni-th width="50" align="center">备注</uni-th>
							<uni-th width="50" align="center">录入时间</uni-th>
						</uni-tr>
						<uni-tr>
							<uni-td align="center">{{ item.score ? item.score : '暂无' }}</uni-td>
							<uni-td align="center">
								<view class="name">{{ item.points ? item.points : '暂无' }}</view>
							</uni-td>
							<uni-td align="center">{{ item.rank }}</uni-td>
							<uni-td align="center">{{ item.updateTime }}</uni-td>
						</uni-tr>
					</uni-table>
				</uni-group>
			</uni-section> -->
		</view>

	</view>
</template>

<script>
	import {
		getMyGames,
		getMyGameBygameId
	} from '@/api/sportmeeting/mygame.js';
	import {
		cancelGame
	} from '@/api/sportmeeting/register.js';
	export default {
		data() {
			return {
				// 弹出询问取消
				show: false,
				// 当前的比赛id
				gid: undefined,
				// 比赛信息集
				dataList: [],
				// 比赛结果集
				gameDetails: [],
			}
		},
		methods: {
			feedback() {
				uni.showToast({
					title: '已提交反馈',
					icon: 'success'
				})
			},
			toGetDesc(gameId) {
				uni.navigateTo({
					url: './gameDetail/gameDetail?gid=' + gameId
				})
			},
			/** 获取比赛详情 */
			getDetail(gid) {},
			/** 获取数据 */
			getData() {
				getMyGames().then(res => {
					this.dataList = res.rows;
					uni.hideLoading();
				})
			},
			/** 取消报名 */
			cancle(gid) {

				cancelGame(gid).then(res => {
					uni.showToast({
						title: res.msg
					});
					uni.showLoading({
						title: '刷新中'
					})
					this.getData()

				})
				this.gid = undefined;
				this.show = false;
			}
		},
		onLoad() {
			this.getData()
		}
	}
</script>

<style scope>
	.itembutton {
		margin: 1rem;
	}

	.game-status {
		margin: 0.5rem;
		text-align: center;
	}

	.operrations {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
	}
</style>
