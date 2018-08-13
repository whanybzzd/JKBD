//
//  DataModel.h
//  GeneralFramework
//
//  Created by ZMJ on 15/4/19.
//  Copyright (c) 2015年 ZMJ. All rights reserved.
//

#import "BaseModel.h"
@protocol DataModel                 @end
@protocol ParentModel               @end
@protocol SearchCustomerModel               @end
@protocol AssetsViewModel               @end
@protocol BillViewModel               @end
@protocol BillistViewModel               @end
@protocol TmpinformationistViewModel               @end
@protocol loadbillStatusViewModel               @end
@protocol BillDetaillist               @end
@protocol listDataViewModel               @end
@protocol listDataDetailViewModel               @end
@protocol listDataDetail2ViewModel               @end
@protocol listEndDataDetailViewModel               @end
@protocol listEndDataDetail2ViewModel               @end
@protocol AssetCarDetail               @end
@protocol AuditlogViewModel               @end
@protocol NewVersionViewModel               @end

@protocol CarTypeViewModel               @end
@protocol LoanTypeViewModel               @end
@protocol MarriageTypeViewModel               @end
@protocol PersonTypeViewModel               @end
@protocol AllTypeViewModel               @end
@protocol HomePushViewModel               @end
@protocol PushlistViewModel               @end
@protocol PushDetailViewModel               @end
@class DataModel,ParentModel,SearchCustomerModel,AssetsViewModel,BillViewModel,BillistViewModel,TmpinformationistViewModel,loadbillStatusViewModel,BillDetaillist,listDataViewModel,listDataDetailViewModel,listDataDetail2ViewModel,listEndDataDetailViewModel,listEndDataDetail2ViewModel,AssetCarDetail,AuditlogViewModel,NewVersionViewModel,CarTypeViewModel,LoanTypeViewModel,MarriageTypeViewModel,PersonTypeViewModel,AllTypeViewModel,HomePushViewModel,PushlistViewModel,PushDetailViewModel;

@interface DataModel : BaseDataModel


@end


@interface ParentModel : BaseDataModel
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lastLoginTime;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *pswd;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *avaterUrl;
@end


@interface SearchCustomerModel :BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *card_number;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *marriage_type;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *business;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *detailAddress;
@property (nonatomic, copy) NSString *executeType;
@property (nonatomic, copy) NSString *familyIncome;
@property (nonatomic, copy) NSString *personType;
@property (nonatomic, assign) BOOL show;
@end

@interface AssetsViewModel : BaseDataModel
@property (nonatomic, copy) NSString *assess_money;
@property (nonatomic, copy) NSString *customer_name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *time;
@end


@interface BillViewModel : BaseDataModel
@property (nonatomic, copy) NSString *apply_time;
@property (nonatomic, copy) NSString *assess_money;
@property (nonatomic, copy) NSString *customer_name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_project;
@property (nonatomic, copy) NSString *loan_term;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *loan_money;
@property (nonatomic, copy) NSString *loan_type;
@end

@interface BillistViewModel : BaseDataModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *card_type;
@property (nonatomic, copy) NSString *card;
@property (nonatomic, copy) NSString *mobile_number;
@end

@interface TmpinformationistViewModel : BaseDataModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *asset_type;
@end

@interface loadbillStatusViewModel : BaseDataModel
@property (nonatomic, copy) NSString *apply_time;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *assess_money;
@property (nonatomic, copy) NSString *loan_term;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *is_project;
@property (nonatomic, copy) NSString *customer_name;
@property (nonatomic, copy) NSString *loan_money;
@property (nonatomic, copy) NSString *loan_type;
@end


@interface BillDetaillist : BaseDataModel

@property (nonatomic, copy) NSString *assetId;
@property (nonatomic, copy) NSString *commonId;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, copy) NSString *assetName;
@property (nonatomic, copy) NSString *assetType;
@property (nonatomic, copy) NSString *commonName;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *loanMoney;
@property (nonatomic, copy) NSString *loanRate;
@property (nonatomic, copy) NSString *loanTerm;
@property (nonatomic, copy) NSString *loanType;
@property (nonatomic, copy) NSString *loanUse;
@property (nonatomic, strong) NSArray *idCard;
@property (nonatomic, strong) NSArray *houseCard;
@property (nonatomic, strong) NSArray *accountPage;
@property (nonatomic, strong) NSArray *other;
@property (nonatomic, strong) NSArray *agreement;//合同项目
@property (nonatomic, assign) BOOL show;
@end

@interface listDataViewModel:BaseDataModel

@property (nonatomic, copy) NSString *hksj;//还款时间
@property (nonatomic, copy) NSString *jkje;//借款金额
@property (nonatomic, copy) NSString *jksj;//借款时间
@property (nonatomic, copy) NSString *khbh;//客户编号
@property (nonatomic, copy) NSString *khmc;//客户名称
@property (nonatomic, copy) NSString *mxlx;//明细类型
@property (nonatomic, copy) NSString *qyjl;//区域经理
@property (nonatomic, copy) NSString *ssfgs;//所属分公司
@property (nonatomic, copy) NSString *ywlx;//业务类型
@property (nonatomic, copy) NSString *ywy;//业务员
@property (nonatomic, assign) BOOL show;//是否展示
@end


@interface listDataDetailViewModel:BaseDataModel

@property (nonatomic, copy) NSString *YLL;//月利率
@property (nonatomic, copy) NSString *dzrq;//实际到账日期
@property (nonatomic, copy) NSString *jxje;//计息金额
@property (nonatomic, copy) NSString *jxrq;//计息日期
@property (nonatomic, copy) NSString *khbh;//客户编号
@property (nonatomic, copy) NSString *nd;//年度
@property (nonatomic, copy) NSString *sflx;//实付利息
@property (nonatomic, copy) NSString *yflx;//应付利息
@property (nonatomic, copy) NSString *yfqs;//月份
@property (nonatomic, copy) NSString *yqfx;//逾期罚息
@property (nonatomic, copy) NSString *yqts;//逾期天数
@end


@interface listDataDetail2ViewModel:BaseDataModel

@property (nonatomic, copy) NSString *khbh;//客户编号
@property (nonatomic, copy) NSString *nd;//年度
@property (nonatomic, copy) NSString *qs;//期数
@property (nonatomic, copy) NSString *yhbj;//应还本金
@property (nonatomic, copy) NSString *yhlx;//应还利息
@property (nonatomic, copy) NSString *fwf;//服务费
@property (nonatomic, copy) NSString *yhhj;//应还合计
@property (nonatomic, copy) NSString *hkrq;//还款日期
@property (nonatomic, copy) NSString *dzje;//到账金额
@property (nonatomic, copy) NSString *dzrq;//到账日期
@property (nonatomic, copy) NSString *yqts;//逾期天数
@property (nonatomic, copy) NSString *znj;//滞纳金
@property (nonatomic, copy) NSString *s_znj;//实收滞纳金
@property (nonatomic, copy) NSString *jklx;//借款类型
@end



@interface listEndDataDetailViewModel:BaseDataModel

@property (nonatomic, copy) NSString *yj_lx;//应缴（利息）
@property (nonatomic, copy) NSString *yj_fx;//应缴（罚息）
@property (nonatomic, copy) NSString *yj_wyj;//应缴（违约金）
@property (nonatomic, copy) NSString *yj_zq;//应缴（展期费用）
@property (nonatomic, copy) NSString *yj_bj;//应缴（本金）
@property (nonatomic, copy) NSString *yj_hj;//应缴（合计）
@property (nonatomic, copy) NSString *sj_lx;//实缴（利息）
@property (nonatomic, copy) NSString *sj_fx;//实缴（罚息）
@property (nonatomic, copy) NSString *sj_wyj;//实缴（违约金）
@property (nonatomic, copy) NSString *sj_zq;//实缴（展期费用）
@property (nonatomic, copy) NSString *sj_bj;//应缴（本金）
@property (nonatomic, copy) NSString *sj_hj;//实缴（合计）


@end


@interface listEndDataDetail2ViewModel:BaseDataModel

@property (nonatomic, copy) NSString *yj_bx;//应缴（本、息）
@property (nonatomic, copy) NSString *yj_znj;//应缴（滞纳金）
@property (nonatomic, copy) NSString *yj_wyj;//应缴（违约金）
@property (nonatomic, copy) NSString *yj_bzj;//应缴（保证金）
@property (nonatomic, copy) NSString *yj_hj;//应缴（合计）
@property (nonatomic, copy) NSString *sj_bx;//实缴（本、息）
@property (nonatomic, copy) NSString *sj_znj;//实缴（滞纳金）
@property (nonatomic, copy) NSString *sj_wyj;//实缴（违约金）
@property (nonatomic, copy) NSString *sj_bzj;//实缴（保证金）
@property (nonatomic, copy) NSString *sj_hj;//实缴（合计）


@end


@interface AssetCarDetail :BaseDataModel
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *asset_type;
@property (nonatomic, copy) NSString *buy_date;
@property (nonatomic, copy) NSString *car_brand;
@property (nonatomic, copy) NSString *car_type;
@property (nonatomic, copy) NSString *covered_area;
@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *displacement;
@property (nonatomic, copy) NSString *driving_license;
@property (nonatomic, copy) NSString *house_status;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *id_card;
@property (nonatomic, copy) NSString *is_servicing;
@property (nonatomic, copy) NSString *mileage;
@property (nonatomic, copy) NSString *model_number;
@property (nonatomic, copy) NSString *mortgage_type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *obligee;
@property (nonatomic, copy) NSString *plate_number;
@property (nonatomic, copy) NSString *property_number;
@property (nonatomic, copy) NSString *structure;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) BOOL show;
@end


@interface AuditlogViewModel : BaseDataModel
@property (nonatomic, copy) NSString *create_date;
@property (nonatomic, copy) NSString *invalid;
@property (nonatomic, copy) NSString *major;
@property (nonatomic, copy) NSString *opinion;
@property (nonatomic, copy) NSString *price_max;
@property (nonatomic, copy) NSString *price_min;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *username;
@end

@interface NewVersionViewModel : BaseDataModel

@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *editionNumber;
@property (nonatomic, copy) NSString *url;

@end


//身份证类型
@interface CarTypeViewModel : BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;


@end


//贷款类型
@interface LoanTypeViewModel : BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;


@end

//婚姻类型
@interface MarriageTypeViewModel : BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;


@end

//个人类型
@interface  PersonTypeViewModel : BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

@end


@interface  AllTypeViewModel : BaseDataModel

@property (nonatomic, strong) NSArray<CarTypeViewModel> *cardTypes;
@property (nonatomic, strong) NSArray<LoanTypeViewModel> *loanTypes;
@property (nonatomic, strong) NSArray<MarriageTypeViewModel> *marriageTypes;
@property (nonatomic, strong) NSArray<PersonTypeViewModel> *personTypes;
@end



@interface  HomePushViewModel : BaseDataModel

@property (nonatomic, copy) NSString *type1;
@property (nonatomic, copy) NSString *type2;
@property (nonatomic, copy) NSString *type3;
@property (nonatomic, copy) NSString *type4;
@property (nonatomic, copy) NSString *type5;

@end


@interface  PushlistViewModel : BaseDataModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;

@end


@interface  PushDetailViewModel : BaseDataModel

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;

@end







