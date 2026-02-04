import 'dotenv/config';
import { AppDataSource } from '../data-source';
import { User, UserRole } from '../modules/auth/entities/user.entity';
import * as bcrypt from 'bcrypt';

async function seedUsers() {
  await AppDataSource.initialize();

  const userRepository = AppDataSource.getRepository(User);

  const users = [
    {
      email: 'admin@myfm.dev',
      password: 'admin123',
      displayName: 'MyFM Admin',
      role: UserRole.ADMIN,
    },
    {
      email: 'user@myfm.dev',
      password: 'user123',
      displayName: 'Demo User',
      role: UserRole.USER,
    },
  ];

  for (const u of users) {
    const exists = await userRepository.findOne({
      where: { email: u.email },
    });

    if (exists) {
      console.log(`User ${u.email} already exists, skipping`);
      continue;
    }

    const passwordHash = await bcrypt.hash(u.password, 10);

    const user = userRepository.create({
      email: u.email,
      passwordHash,
      displayName: u.displayName,
      role: u.role,
      emailVerified: true,
      isActive: true,
    });

    await userRepository.save(user);
    console.log(`Created user ${u.email}`);
  }

  await AppDataSource.destroy();
}

seedUsers()
  .then(() => {
    console.log('Seeding completed');
    process.exit(0);
  })
  .catch((err) => {
    console.error('Seeding failed', err);
    process.exit(1);
  });
