const baseUrl = "https://abitly.herokuapp.com";
// final accessToken = UserPreference.getAccessToken();
// final userId = UserPreference.getId();

// Agent
const kCreateAccountAgentUrl = "$baseUrl/api/v1/agents/signup";
const kVerifyAgenttUrl = "$baseUrl/api/v1/agents/auth/verify/number";
const kLoginAgentUrl = "$baseUrl/api/v1/agents/login";
const kResendOTPAgentUrl = "$baseUrl/api/v1/agents/email/resend";

// Aggregator
const kCreateAccountAggregatorUrl = "$baseUrl/api/v1/aggregators/signup";
const kVerifyAggregatorUrl = "$baseUrl/api/v1/aggregators/auth/verify/number";
const kLoginAggregatorUrl = "$baseUrl/api/v1/aggregators/login";
const kResendOTPAggregatorUrl = "$baseUrl/api/v1/aggregators/email/resend";
