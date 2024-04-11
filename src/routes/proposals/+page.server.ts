import type { PageServerLoad } from './$types';
import { prisma } from '$lib/server/prisma';
import type { ProposalWithUser } from '$lib/types/Proposal';
import type { Actions } from '@sveltejs/kit';

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

export const actions: Actions = {
	checkProject: async () => {
		console.log('checkProject');
	}
}