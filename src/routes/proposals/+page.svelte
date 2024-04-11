<script lang="ts">
  import type { PageData } from "./$types";
  import type { ProposalWithUser } from "$lib/types/Proposal";

  export let data: PageData;
  let proposals: ProposalWithUser[] = data.proposals;
</script>

<div class="container h-full mx-auto">
  <h2 class="h2 py-4 mb-4">Propuestas</h2>

  <div class="table-container space-y-4">
    <table class="table table-hover table-compact table-auto w-full">
      <thead>
        <tr>
          <td>Acciones</td>
          <td>Revisado?</td>
          <td>ID</td>
          <td>Código</td>
          <td>Título</td>
          <td>Nombre Usuario</td>
          <td>Email</td>
        </tr>
      </thead>
      <tbody>
        {#each proposals as proposal (proposal.key)}
          <tr>
            <td class="flex space-x-4">
              <button title="Detalles" on:click={() => console.log("detalles")}
                >🔎</button
              >
              <button
                title="Descartar"
                on:click={() => console.log("descartar")}>❌</button
              >
            </td>
            <td>
              <form
                method="POST"
                action="?/checkProposal&id={proposal.key}&checked={proposal.checked}"
              >
                <input
                  type="checkbox"
                  class="checkbox"
                  name=""
                  id=""
                  checked={proposal.checked}
                  on:click={() =>
                    console.log(
                      "status: ",
                      (proposal.checked = !proposal.checked)
                    )}
                />
              </form>

              <!-- <select class="select border-0 width-full leading-4">
								<option value="true">✅</option>
								<option value="true">❌</option>
							</select> -->
            </td>
            <td>{proposal.id}</td>
            <td class="align-middle">{proposal.code}</td>
            <td>{proposal.title}</td>
            <td>{proposal.user.name}</td>
            <td>{proposal.user.email}</td>
          </tr>
        {/each}
      </tbody>
    </table>
  </div>
</div>
