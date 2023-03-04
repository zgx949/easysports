<template>
	<view class="result">
		<uni-table ref="table" border stripe emptyText="暂无更多数据">
			<uni-tr>
				<uni-th width="50" align="center">成绩</uni-th>
				<uni-th width="50" align="center">积分</uni-th>
				<uni-th width="50" align="center">备注</uni-th>
				<uni-th width="50" align="center">录入时间</uni-th>
			</uni-tr>
			<uni-tr>
				<uni-td align="center"></uni-td>
				<uni-td align="center"></uni-td>
				<uni-td align="center"></uni-td>
				<uni-td align="center"></uni-td>
			</uni-tr>
		</uni-table>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				gid: null,
			}
		},
		methods: {
			getData
		},
		onLoad(params) {
			this.gid = params.gid;
			// this.title = params.title
			// this.type = params.type
			// this.subtitle = params.subtitle
		}
	}
</script>

<style scope>
	.result {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 1rem;
	}
	.title {
		display: block;
		font-size: 2rem;
		padding-top: 1rem;
	}
	.subtitle {
		display: block;
		padding: 1rem;
		color: #8f9ca2;
	}
</style>
