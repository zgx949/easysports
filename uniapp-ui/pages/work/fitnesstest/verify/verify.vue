<template>
	<view>
		
		<u-notice-bar :fontSize="20" :text="notice"></u-notice-bar>
		<view class="title">{{ this.times == this.refreshTime? '刷新中...' : `还有${refreshTime - times}S刷新二维码` }}</view>
		<view class="subtitle">临时令牌：{{ code }}</view>
		<view style="display: flex; justify-content: center;">
		<view class="code" @click="refreshQrCode()">
			<ayQrcode
				ref="qrcode" 
				:modal="modal_qr" 
				:url="code" 
				@hideQrcode="hideQrcode" 
				:height="300" 
				:width="300" 
			/>
		</view>
		</view>
		<uni-card title="个人信息" thumbnail="" :extra="userInfo.dept.deptName" note="Tips">
			<view>学号：{{ userInfo.userName }}</view>
			<view>姓名：{{ userInfo.nickName }}</view>
			<view>性别：{{ userInfo.sex === '0' ? '女' : '男' }}</view>
		</uni-card>
	</view>
	
</template>

<script>
	import { getQrCode } from '@/api/fitnesstest/activities.js'
	import { getUserProfile } from '@/api/system/user.js'
	import ayQrcode from "@/components/ay-qrcode/ay-qrcode.vue"
	export default {
		components: {
			ayQrcode,
		},
		computed: {
		},
		data() {
			return {
				userInfo: {},
				notice: '二维码有效期仅有15秒，若二维码失效请点击图片刷新二维码', 
				modal_qr: false,
				code: '',
				times: 0,
				// 刷新时间
				refreshTime: 15,
				timer: null,
			}
		},
		onUnload() {//离开页面前清除计时器
			clearInterval(this.timer);
			this.timer = null;
		},
		onHide() {
			clearInterval(this.timer);
			this.timer = null;
		},
		onShow() {
			getUserProfile().then(res => {
				this.userInfo = res.data
			})
			let that = this;
			getQrCode().then(res => {
				this.code = res;
				that.showQrcode(); //一加载生成二维码
			})
			
			that.init();
		},
		methods: {
			init () {
				this.timer = setInterval(() => {
					this.times = (this.times + 1) % this.refreshTime;
					if (this.times === 0) {
						this.refreshQrCode();
						return
					}
					
				}, 1000)
			},
			// 展示二维码
			showQrcode() {
				let _this = this;
				this.modal_qr = true;
				// uni.showLoading()
				setTimeout(function() {
					// uni.hideLoading()
					_this.$refs.qrcode.crtQrCode()
				}, 50)
			},
			//刷新二维码
			refreshQrCode () {
				// console.log('刷新二维码');
				// this.code += 'asd';
				getQrCode().then(res => {
					this.code = res;
				})
				this.times = 0;
				this.$refs.qrcode.crtQrCode()
			},
			//传入组件的方法
			hideQrcode() {
				this.modal_qr = false;
			},
		}
	}
</script>

<style lang="scss">
.title {
	font-size: 1.5rem;
	text-align: center;
	padding: 1rem;
}
.subtitle {
	text-align: center;
	padding: 1rem;
}
.code {

}
</style>
