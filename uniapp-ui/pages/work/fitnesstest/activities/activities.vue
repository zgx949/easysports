<template>
	<view>
		<view v-for="(item,index) in items" :key="index">
			<uni-card 
				:title="item.name" 
				:sub-title="item.gender" 
				:extra="'测试日期：' + item.startTime" 
				thumbnail="https://vkceyugu.cdn.bspapp.com/VKCEYUGU-dc-site/460d46d0-4fcc-11eb-8ff1-d5dcf8779628.png"
			>
				<text>{{ item.remark }}</text>
				<view class="card-actions-item">
					<view v-if="item.status === 0">
						<u-button type="primary" icon="plus" text="暂时无需报名" :disabled="true"></u-button>
					</view>
					<view v-else>
						<u-button type="primary" icon="plus" text="已截止" :disabled="true"></u-button>
					</view>
				</view>
			</uni-card>
		</view>
	</view>
</template>

<script>
	import { getFitnessTestActivities } from "@/api/fitnesstest/activities"
	export default {
		data() {
			return {
				items: []
			}
		},
		methods: {
		},
		mounted() {
			getFitnessTestActivities().then(res => {
				this.items = res.rows
			})
		}
	}
</script>

<style>
.card-actions-item {
	padding: 1rem;
	
} 
</style>
