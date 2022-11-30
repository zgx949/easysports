package com.ruoyi.system.domain.Vo;

import com.ruoyi.system.domain.FitnessTestGrade;

import java.io.Serializable;
import java.util.List;

/**
 * author: Luo Shiquan
 * Date: 2022/10/15 15:38
 * Description :
 */
public class InsertFitnessTestGradeVo implements Serializable {
    private int successCount;
    private List<FitnessTestGrade> failInsertList;
    private boolean isAllInsertSuccess;

    public int getSuccessCount() {
        return successCount;
    }

    public void setSuccessCount(int successCount) {
        this.successCount = successCount;
    }

    public List<FitnessTestGrade> getFailInsertList() {
        return failInsertList;
    }

    public void setFailInsertList(List<FitnessTestGrade> failInsertList) {
        this.failInsertList = failInsertList;
    }

    public boolean isAllInsertSuccess() {
        return isAllInsertSuccess;
    }

    public void setAllInsertSuccess(boolean allInsertSuccess) {
        isAllInsertSuccess = allInsertSuccess;
    }
}
