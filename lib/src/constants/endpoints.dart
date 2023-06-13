const baseUrl = "https://abitly.herokuapp.com";
// final accessToken = UserPreference.getAccessToken();
// final userId = UserPreference.getId();

// Agent
const kCreateAccountAgentUrl = "$baseUrl/api/v1/agents/signup";
const kVerifyAgenttUrl = "$baseUrl/api/v1/agents/auth/verify/number";
const kLoginAgentUrl = "$baseUrl/api/v1/agents/login";
const kResendOTPAgentUrl = "$baseUrl/api/v1/agents/email/resend";
const kPasscodeAgentUrl = "$baseUrl/api/v1/agents/set/passcode";
const kPinResetAgentUrl = "$baseUrl/api/v1/agents/forgot-password";
const kInputNewPinAgentUrl = "$baseUrl/api/v1/agents/reset-password";

// Aggregator
const kCreateAccountAggregatorUrl = "$baseUrl/api/v1/aggregators/signup";
const kVerifyAggregatorUrl = "$baseUrl/api/v1/aggregators/auth/verify/number";
const kLoginAggregatorUrl = "$baseUrl/api/v1/aggregators/login";
const kResendOTPAggregatorUrl = "$baseUrl/api/v1/aggregators/email/resend";
const kPasscodeAggregatorUrl = "$baseUrl/api/v1/aggregators/set/passcode";
const kPinResetAggregatorUrl = "$baseUrl/api/v1/aggregators/forgot-password";
const kInputNewPinAggregatorUrl = "$baseUrl/api/v1/aggregators/reset-password";
