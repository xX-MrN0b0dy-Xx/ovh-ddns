A simple but effective containerized implementation of my script (visible at this link) to update the Dynamic Public IP utilizing the OVH DDNS Service DynHost.

The container exposes the following `ENV` variables, that can be seen also from [`compose.yaml`](./compose.yaml):
- `HOSTNAME: "${HOSTNAME}"`
- `LOGIN: "${LOGIN}"`
- `PASSWORD: "${PASSWORD}"`
- `LOG_TYPE: file`: values here can be either `'file'` or `'STDOUT'`. Nothing else is accepted. Fallback value if omitted is `'STDOUT'`

It should be simple to create a DynHost user from OVH Control Panel. However, if you need help, read this:

<details>

From OVH dashboard you can create the DynHost user: 
1. Domain names/yourdomain.ovh/DynHost section
2. Manage Access
3. Create a username and the subdomain you wanna redirect the host
4. Then Add a DynHost record with the same subdomain and the current IP of the host

> Remember that for some TLD, redirection to domain.TLD is not possible (ie `.it` doesn't allow this, so if I need to redirect to a domain.it, I'd create `dyn.domain.it` and redirect to it. Then I'll redirect any subdomain to `dyn.domain.it` and I have my Nginx reverse proxy that listen for `dyn.domain.it`)

</details>