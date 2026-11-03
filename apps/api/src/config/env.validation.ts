export function validateEnvironment(
  config: Record<string, unknown>,
): Record<string, unknown> {
  const nodeEnvValue = config.NODE_ENV;
  const nodeEnv = nodeEnvValue ?? 'development';

  const allowedEnvironments = ['development', 'test', 'production'];

  if (typeof nodeEnv !== 'string' || !allowedEnvironments.includes(nodeEnv)) {
    throw new Error('NODE_ENV must be development, test, or production.');
  }

  const portValue = config.PORT ?? '3000';

  if (typeof portValue !== 'string' && typeof portValue !== 'number') {
    throw new Error('PORT must be an integer between 1 and 65535.');
  }

  const port = Number(portValue);

  if (!Number.isInteger(port) || port < 1 || port > 65535) {
    throw new Error('PORT must be an integer between 1 and 65535.');
  }

  const databaseUrl = config.DATABASE_URL;

  if (databaseUrl !== undefined && databaseUrl !== '') {
    if (typeof databaseUrl !== 'string') {
      throw new Error(
        'DATABASE_URL must be a valid PostgreSQL connection URL.',
      );
    }

    try {
      const parsedUrl = new URL(databaseUrl);

      if (
        parsedUrl.protocol !== 'postgres:' &&
        parsedUrl.protocol !== 'postgresql:'
      ) {
        throw new Error();
      }
    } catch {
      throw new Error(
        'DATABASE_URL must be a valid PostgreSQL connection URL.',
      );
    }
  }

  return {
    ...config,
    NODE_ENV: nodeEnv,
    PORT: port,
  };
}
