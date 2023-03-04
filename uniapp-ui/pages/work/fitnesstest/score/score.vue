<template>
	<view>
		<view v-for="(item,index) in dataList" :key="index">
			<uni-section :title="item.name" type="line">
				
				<uni-group mode="card">
					<uni-table ref="table" border stripe emptyText="暂无更多数据">
						<uni-tr>
							<uni-th width="50" align="center">项目</uni-th>
							<uni-th width="50" align="center">成绩</uni-th>
							<uni-th width="50" align="center">得分</uni-th>
							<uni-th width="50" align="center">测试日期</uni-th>
						</uni-tr>
						<uni-tr v-for="(i, j) in item.data" :key="j">
							<uni-td>{{ i.item.itemName }}</uni-td>
							<uni-td>
								<view class="name">{{ i.score }}{{ i.item.unit }}</view>
							</uni-td>
							<uni-td align="center">{{ 'i.score' }}</uni-td>
							<uni-td align="center">{{ i.createTime }}</uni-td>
						</uni-tr>
					</uni-table>
				</uni-group>
			</uni-section>
		</view>

	</view>
</template>

<script>
	import { getMyFitnessTestGrade } from '@/api/fitnesstest/grade.js'
	export default {
		data() {
			return {
				dataList: []
			}
		},
		methods: {
			getMyGrade () {
				getMyFitnessTestGrade().then(res => {
					let tempList = []
					res.data.forEach(item => {
						let temp = item.fta;
						temp.data = []
						
						// 查找原数组是否存在该活动
						let index = 0;
						for (index = 0; index < tempList.length; index++) {
							if (tempList[index].id == item.fta.id) {
								temp = tempList[index];
								break;
							}
						}
						
						let record = {}
						record.userId = item.userId;
						record.userName = item.userName;
						record.gender = item.gender;
						record.dept = item.dept;
						
						record.item = item.item;
						record.score = item.score;
						record.createUser = item.createUser;
						record.updateUser = item.updateUser;
						record.createTime = item.createTime.substr(0,10);
						temp.data.push(record)
						// 新活动
						if (index === tempList.length) {
							tempList.push(temp);
						}
						
					})
					this.dataList = tempList
					console.log(this.dataList);
					
				})
			}

		},
		onLoad() {
			this.getMyGrade();
		}
	}
</script>

<style>

</style>
