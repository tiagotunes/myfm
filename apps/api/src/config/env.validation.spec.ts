import { validateEnvironment } from './env.validation';

describe('validateEnvironment', () => {
  it('should apply default values when optional variables are missing', () => {
    const result = validateEnvironment({});

    expect(result.NODE_ENV).toBe('development');
    expect(result.PORT).toBe(3000);
  });

  it('should accept valid environment variables', () => {
    const result = validateEnvironment({
      NODE_ENV: 'production',
      PORT: '8080',
      DATABASE_URL: 'postgresql://user:password@localhost:5432/myfm',
    });

    expect(result.NODE_ENV).toBe('production');
    expect(result.PORT).toBe(8080);
  });

  it('should reject an invalid NODE_ENV', () => {
    expect(() =>
      validateEnvironment({
        NODE_ENV: 'staging',
      }),
    ).toThrow('NODE_ENV must be development, test, or production.');
  });

  it.each(['0', '65536', '3.5', 'invalid'])(
    'should reject an invalid PORT value: %s',
    (port) => {
      expect(() =>
        validateEnvironment({
          PORT: port,
        }),
      ).toThrow('PORT must be an integer between 1 and 65535.');
    },
  );

  it('should reject a non-numeric PORT value', () => {
    expect(() =>
      validateEnvironment({
        PORT: true,
      }),
    ).toThrow('PORT must be an integer between 1 and 65535.');
  });

  it('should reject a malformed DATABASE_URL', () => {
    expect(() =>
      validateEnvironment({
        DATABASE_URL: 'not-a-valid-url',
      }),
    ).toThrow('DATABASE_URL must be a valid PostgreSQL connection URL.');
  });

  it('should reject a non-PostgreSQL DATABASE_URL', () => {
    expect(() =>
      validateEnvironment({
        DATABASE_URL: 'https://localhost:5432/myfm',
      }),
    ).toThrow('DATABASE_URL must be a valid PostgreSQL connection URL.');
  });
});
