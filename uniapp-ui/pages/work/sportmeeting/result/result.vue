<template>
	<view class="result">
		<u-icon v-if="type==='success'" name="checkmark-circle-fill" color="#2979ff" size="100"></u-icon>
		<u-icon v-else="type==='error'" name="close-circle-fill" color="#fa3534" size="100"></u-icon>
		<text class="title">{{ title }}</text>
		<text class="subtitle">{{ subtitle }}</text>
		<u-button type="primary" text="返回" @click="back()"></u-button>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: '',
				type: '',
				subtitle: ''
			}
		},
		methods: {
			back() {
				uni.navigateBack({delta: 2})
			}
		},
		onLoad(params) {
			this.title = params.title
			this.type = params.type
			this.subtitle = params.subtitle
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
