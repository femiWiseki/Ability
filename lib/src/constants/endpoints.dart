import 'package:ability/src/utils/user_preference/user_preference.dart';

const baseUrl = "https://api.supplysmart.co";
final dataNtw = AgentPreference.getDataNetwork();
final accStartDate = AgentPreference.getAccStartDate();
final accEndDate = AgentPreference.getAccEndDate();

// final dataNtw = AgentPreference.getDataNetwork();
// final accessToken = UserPreference.getAccessToken();
// final userId = UserPreference.getId();

// Agent
const kRefreshTokenUrl = "$baseUrl/api/v1/agents/refresh/token";
const kCreateAccountAgentUrl = "$baseUrl/api/v1/agents/signup";
const kVerifyAgenttUrl = "$baseUrl/api/v1/agents/auth/verify/number";
const kLoginAgentUrl = "$baseUrl/api/v1/agents/login";
const kFingerprintLoginUrl = "$baseUrl/api/v1/agents/login/biometric";
const kPasscodeLoginAgentUrl = "$baseUrl/api/v1/agents/login/passcode";
const kResendOTPAgentUrl = "$baseUrl/api/v1/agents/email/resend";
const kPasscodeAgentUrl = "$baseUrl/api/v1/agents/set/passcode";
const kPinResetAgentUrl = "$baseUrl/api/v1/agents/forgot-password";
const kInputNewPinAgentUrl = "$baseUrl/api/v1/agents/reset-password";
const kResolveAccountNumberUrl =
    "$baseUrl/api/v1/agents/resolve/account/number";
const kMakeTransferUrl = "$baseUrl/api/v1/agents/transfer";
const kSaveBeneficiaryUrl = "$baseUrl/api/v1/agents/save/beneficiary";
const kAgtTransHistoryUrl = "$baseUrl/api/v1/agents/transaction-history";
const kAgtWithdrawalHistoryUrl =
    "$baseUrl/api/v1/agents/withdrawal/notifications";
const kAgtProfileUrl = "$baseUrl/api/v1/agents/profile";
const kAgtResetPasscodeUrl = "$baseUrl/api/v1/agents/forgot/passcode";
const kAgtVerifyResetPasscodeUrl =
    "$baseUrl/api/v1/agents/verify/reset/passcode";
const kAgtSaveBeneficiaryUrl = "$baseUrl/api/v1/agents/save/beneficiary";
const kAgtGetSavedBeneficiaryUrl = "$baseUrl/api/v1/agents/beneficiaries";

// Agent Transfer Urls
const kSupplySmartTransferUrl = "$baseUrl/api/v1/agents/intra/bank/transfer";
const kBanksDetailsUrls = "$baseUrl/bank";

// Agent Home Urls
const kRaiseDisputeUrl = "$baseUrl/api/v1/agents/raise/dispute";
const kNotificationsUrl = "$baseUrl/api/v1/agents/my-notification";
const kDeleteSingleNotiUrl = "$baseUrl/api/v1/agents/notification";
const kDeleteAllNotiUrl = "$baseUrl/api/v1/agents/notifications";

// Agent Payment Urls
const kSendBillDetailsUrl = "$baseUrl/api/v1/agents/bill";
var kGetDataUrl =
    "$baseUrl/api/v1/agents/billcategories/$dataNtw?data_bundle=1";
var kGetCableUrl =
    "$baseUrl/api/v1/agents/billcategories/$dataNtw?data_bundle=1";
const kElectricityListUrl =
    "$baseUrl/api/v1/agents/bill/major/categories?power=1";
const kResolveElectricityUrl = "$baseUrl/api/v1/agents/bill/validation";
const kCableListUrl = "$baseUrl/api/v1/agents/bill/major/categories?cable=1";
const kResolveCableUrl = "$baseUrl/api/v1/agents/bill/validation";

// Agent Profile Urls
var kAgtAccStatementUrl =
    "$baseUrl/api/v1/agents/download/transactions?startDate=$accStartDate&endDate=$accEndDate";
var kEnrollFingerPrintUrl = "$baseUrl/api/v1/agents/biometric";
const kUploadPhotoUrl = "$baseUrl/api/v1/agents/profile/picture";
const kAgtAccVerificationUrl = "$baseUrl/api/v1/agents/upload/documents";

// Aggregator
const kCreateAccountAggregatorUrl = "$baseUrl/api/v1/aggregators/signup";
const kVerifyAggregatorUrl = "$baseUrl/api/v1/aggregators/auth/verify/number";
const kLoginAggregatorUrl = "$baseUrl/api/v1/aggregators/login";
const kPasscodeLoginAggUrl = "$baseUrl/api/v1/aggregators/login/passcode";
const kResendOTPAggregatorUrl = "$baseUrl/api/v1/aggregators/email/resend";
const kPasscodeAggregatorUrl = "$baseUrl/api/v1/aggregators/set/passcode";
const kPinResetAggregatorUrl = "$baseUrl/api/v1/aggregators/forgot-password";
const kInputNewPinAggregatorUrl = "$baseUrl/api/v1/aggregators/reset-password";
