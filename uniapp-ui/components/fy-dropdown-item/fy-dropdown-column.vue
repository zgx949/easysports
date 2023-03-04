<template>
    <view class="fy-dropdown-floor">
        <scroll-view :scroll-y="true" style="height: 220px;">
            <view class="fy-dropdown-floor_item" v-for="(item, index) in options" :key="index">
                <text class="fy-dropdown-floor_title">{{ item.title }}</text>
                <view class="fy-dropdown-floor_ul">
                    <text :class="['fy-dropdown-floor_li', selected[item.key] == cell.value ? 'fy-dropdown-floor_li__active' : '']" v-for="(cell, cellIndex) in item.list" :key="cellIndex" @click.stop.prevent="handlerCellClick(item.key, cell.value)">{{ cell.text }}</text>
                </view>
            </view>
        </scroll-view>
        <view class="fy-dropdown-button-list">
            <button class="fy-dropdown-button-item" @click.stop.prevent="handlerCancel"><text class="fy-dropdown-button-text" :style="{color: cancelColor}">取消</text></button>
            <text class="fy-dropdown-button-border-left"></text>
            <button class="fy-dropdown-button-item" @click.stop.prevent="handlerConfirm"><text class="fy-dropdown-button-text" :style="{color: confirmColor}">确定</text></button>
        </view>
    </view>
</template>

<script>
export default {
    props: {
        // 选项数据，如果传入了默认slot，此参数无效
		options: {
			type: Array, default () { return [] }
		},
        cancelColor: {
            type: String, default: '#333333'
        },
        confirmColor: {
            type: String, default: '#4cd964'
        },
    },
    data() {
        return {
            selected: {}, // 存储选中的值
        }
    },
    watch: {
        options: {
            immediate: true, deep: true,
            handler: function(list) {
                for (var i = 0, len = list.length; i < len; i++) {
                    if (list[i]['key']) {
                        this.$set(this.selected, list[i]['key'], list[i]['default']);
                    }
                }
            }
        }
    },
    methods: {
        handlerCellClick(key, data) {
            this.$set(this.selected, key, data);
        },
        handlerCancel() {
            this.$emit('success', { cancel: true, type: 'column', })
        },
        handlerConfirm() {
            try {
                this.$emit('success', { confirm: true, type: 'column', data: JSON.parse(JSON.stringify(this.selected)) })
            } catch(err) {
                this.$emit('success', { confirm: true, type: 'column', data: JSON.parse(JSON.stringify(this.selected)) })
            }
        }
    },
}
</script>

<style lang="scss" scoped>
// 定义混入指令，用于在非nvue环境下的flex定义，因为nvue没有display属性，会报错
@mixin vue-flex($direction: row) {
	/* #ifndef APP-NVUE */
	display: flex;
	/* #endif */
	flex-direction: $direction;
}
// @include vue-flex;

.fy-dropdown-floor{background-color: #ffffff;border-top: 1px solid #f2f2f2;}

.fy-dropdown-floor_item{margin-top: 42rpx;}
.fy-dropdown-floor_title{font-size: 30rpx;color: #333333;padding-bottom: 6rpx;margin-left: 40rpx;font-weight: bold;}
.fy-dropdown-floor_ul{@include vue-flex;align-items: center;flex-wrap: wrap;padding: 0 40rpx 0 20rpx;}
.fy-dropdown-floor_li{border: 1px solid #EFEFEF;height: 52rpx;line-height: 49rpx;text-align: center;padding: 0 28rpx;border-radius: 26rpx;background-color: #EFEFEF;color: #999999;
    font-size: 26rpx;margin-left: 20rpx;margin-top: 20rpx;
}
.fy-dropdown-floor_li__active{border-color: #00BCD4;color: #00BCD4;background-color: #ffffff;}


.fy-dropdown-button-list{@include vue-flex;align-items: center;border-top: 1px solid #f6f6f6;}
.fy-dropdown-button-item{@include vue-flex;align-items: center;justify-content: center;flex: 1;height: 100rpx;background-color: #ffffff;border-radius: 0;border-width: 0rpx;
/* #ifndef APP-NVUE */
	&::after{border: none;}
/* #endif */
}
.fy-dropdown-button-text{font-size: 30rpx;}
.fy-dropdown-button-border-left{width: 1px;height: 100rpx;background-color: #f2f2f2;transform: scaleX(0.7);}
</style>