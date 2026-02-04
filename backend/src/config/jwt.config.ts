export const jwtConfig = {
  secret: process.env.JWT_SECRET,
  accessTokenExpiresIn: process.env.JWT_ACCESS_TOKEN_EXPIRY,
  refreshTokenExpiresIn: process.env.JWT_REFRESH_TOKEN_EXPIRY,
};
