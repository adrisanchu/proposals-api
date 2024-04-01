import type { PageServerLoad } from './$types';
import { prisma } from '$lib/server/prisma';
import type { ProposalWithUser } from '$lib/types/Proposal';

export const load: PageServerLoad = async () => {
	const proposals: ProposalWithUser[] = await prisma.proposal.findMany({
		include: {
			user: true,
		},
	});
	return {
		proposals,
	};
};
