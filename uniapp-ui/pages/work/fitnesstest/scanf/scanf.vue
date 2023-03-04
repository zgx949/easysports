<template>
	<view>
		<u-picker :show="itemSelectorShow" :columns="items" @confirm="closeSelectItem" @cancel="itemSelectorShow = false"></u-picker>
		
		<u-cell-group>
			<u-cell size="large" title="活动:" :value="actName" isLink></u-cell>
			<u-cell size="large" title="测试项目:" :value="itemName" @click="itemSelectorShow = true" isLink></u-cell>
		</u-cell-group>
		<u--input class="row-item" placeholder="学号" prefixIcon="search" prefixIconStyle="font-size: 22px;color: #909399"></u--input>
		<u-button class="row-item" type="success" text="查询" @click="scanf()"></u-button>
		<uni-card title="成绩信息" thumbnail="" extra="未录入" note="Tips">
			<u-cell-group>
				<u-cell size="large" title="姓名:" :value="'name'"></u-cell>
				<u-cell size="large" title="性别:" :value="'itemName'"></u-cell>
				<u-cell size="large" title="学院:" :value="'itemName'"></u-cell>
			</u-cell-group>
			<u--input placeholder="成绩" prefixIconStyle="font-size: 22px;color: #909399"></u--input>
			<u-button class="row-item" type="primary" text="提交" @click="()=>{}"></u-button>
		</uni-card>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				
				// 活动
				actName: null,
				actId: null,
				
				// 项目
				itemName: null,
				itemId: null,
				itemSelectorShow: false,
				items: [
					{
						id: 1,
						name: '体育测试',
					}
				],
			}
		},
		methods: {
			closeSelectItem() {
				this.show = false;
			},
			scanf() {
				uni.scanCode({
					success: function(res) {
						console.log('条码类型：' + res.scanType);
						console.log('条码内容：' + res.result);
					}
				});
			},
		}
	}
</script>

<style scoped>
.row-item {
	margin-top: 1rem;
}
</style>
