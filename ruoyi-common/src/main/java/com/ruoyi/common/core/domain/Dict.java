package com.ruoyi.common.core.domain;

/**
 * @program: Ruoyi-Vue
 * @description: 字典类
 * @author: LeftHand
 * @create: 2022-07-05 17:07
 **/
public class Dict {
    private String label;
    private int    value;

    public Dict() {
    }

    public Dict(String label, int value) {
        this.label = label;
        this.value = value;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
