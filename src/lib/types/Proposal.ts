import { Prisma } from '@prisma/client';

const proposalUser = Prisma.validator<Prisma.ProposalDefaultArgs>()({
	include: { user: true },
});

export type ProposalWithUser = Prisma.ProposalGetPayload<typeof proposalUser>;
