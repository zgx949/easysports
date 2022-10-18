package com.ruoyi.system.domain.Vo;

import com.ruoyi.system.domain.FitnessTestScore;

import java.util.List;

/**
 * author: Luo Shiquan
 * Date: 2022/10/18 14:34
 * Description :
 */
public class InsertFitnessTestScoreVo {
    int successCount;
    List<FitnessTestScore> failedInsertList;
    boolean isAllSuccessInsert;

    public int getSuccessCount() {
        return successCount;
    }

    public void setSuccessCount(int successCount) {
        this.successCount = successCount;
    }

    public List<FitnessTestScore> getFailedInsertList() {
        return failedInsertList;
    }

    public void setFailedInsertList(List<FitnessTestScore> failedInsertList) {
        this.failedInsertList = failedInsertList;
    }

    public boolean isAllSuccessInsert() {
        return isAllSuccessInsert;
    }

    public void setAllSuccessInsert(boolean allSuccessInsert) {
        isAllSuccessInsert = allSuccessInsert;
    }
}
