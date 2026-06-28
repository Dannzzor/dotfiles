Generate a `dashboard-export.json` file in the current directory for import into ProjectDashboard.

## Instructions

Read the following files using the Read tool (do not use cat/bash):
1. `package.json` — extract name, description, repository URL, and dependencies
2. `README.md` — extract description (first non-heading paragraph) and live URL if present
3. `.claude-context/STATUS.md` — first choice for roadmap items
4. `CLAUDE.md` — second choice for roadmap items
5. `STATUS.md` — third choice for roadmap items
6. `TODO.md` — fourth choice for roadmap items

Also run: `git remote get-url origin` to get the repo URL if not in package.json.

## Output file format

Write `dashboard-export.json` with exactly this shape (omit optional fields if not found):

```json
{
  "name": "project name",
  "description": "one sentence description",
  "repoUrl": "https://github.com/...",
  "liveUrl": "https://...",
  "roadmapItems": [
    { "title": "Feature name", "status": "complete" }
  ],
  "tools": [
    { "name": "Supabase", "category": "database", "billingUrl": "https://app.supabase.com/account/billing", "monthlyCost": 0 }
  ]
}
```

## Rules

**name**: `package.json` name field, strip `@scope/` prefix. Fall back to current directory name.

**description**: `package.json` description. If missing, use the first paragraph from README.md that is not a heading, badge, or HTML tag. Strip markdown link syntax. Max 200 characters.

**repoUrl**: `package.json` repository.url or `git remote get-url origin`. Normalize: remove `git+` prefix, convert `git@github.com:user/repo.git` → `https://github.com/user/repo`, strip `.git` suffix.

**liveUrl**: First `https://` URL in README.md that is not github.com, shields.io, or a badge image.

**roadmapItems**: Parse the first markdown table (from the priority list above) that has both a Feature/Name column and a Status column. Extract every data row. Map statuses: Complete/Done → `"complete"`, In Progress → `"in-progress"`, Backlog → `"backlog"`, anything else → `"todo"`. Skip separator rows (`---`).

**tools**: Check `dependencies` and `devDependencies` in package.json. Only include packages from this list (deduplicate by name, set monthlyCost to 0):

| Package | Name | Category | billingUrl |
|---|---|---|---|
| `@supabase/supabase-js`, `@supabase/ssr` | Supabase | database | https://app.supabase.com/account/billing |
| `stripe`, `@stripe/stripe-js` | Stripe | payments | https://dashboard.stripe.com/billing |
| `openai` | OpenAI | ai | https://platform.openai.com/account/billing |
| `@anthropic-ai/sdk` | Anthropic | ai | https://console.anthropic.com/billing |
| `@clerk/nextjs`, `@clerk/clerk-js`, `@clerk/remix`, `@clerk/express` | Clerk | auth | https://dashboard.clerk.com |
| `posthog-js`, `posthog-node` | PostHog | analytics | https://app.posthog.com/billing |
| `@sentry/node`, `@sentry/nextjs`, `@sentry/react`, `@sentry/browser` | Sentry | monitoring | https://sentry.io/settings/billing/ |
| `resend` | Resend | email | https://resend.com/billing |
| `@sendgrid/mail` | SendGrid | email | https://app.sendgrid.com/settings/billing |
| `@upstash/redis`, `@upstash/vector` | Upstash | database | https://console.upstash.com |
| `@neondatabase/serverless` | Neon | database | https://console.neon.tech/billing |
| `firebase`, `@firebase/app` | Firebase | database | https://console.firebase.google.com |
| `@planetscale/database` | PlanetScale | database | https://app.planetscale.com/billing |
| `twilio` | Twilio | email | https://console.twilio.com/billing |
| `mixpanel` | Mixpanel | analytics | https://mixpanel.com/billing |
| `@vercel/analytics`, `@vercel/edge-config` | Vercel | hosting | https://vercel.com/dashboard |
| `cloudinary` | Cloudinary | storage | https://cloudinary.com/billing |
| `@aws-sdk/client-s3` | AWS S3 | storage | https://aws.amazon.com/billing/ |
| `datadog` | Datadog | monitoring | https://app.datadoghq.com/billing/plan |
| `better-auth` | Better Auth | auth | (omit billingUrl) |
| `next-auth`, `@auth/core` | Auth.js | auth | (omit billingUrl) |
| `liveblocks` | Liveblocks | other | https://liveblocks.io/dashboard/billing |
| `pusher` | Pusher | other | https://dashboard.pusher.com/billing |
| `inngest` | Inngest | other | https://app.inngest.com/billing |
| `@trigger.dev/sdk`, `trigger.dev` | Trigger.dev | other | https://cloud.trigger.dev/billing |

## After writing the file

Print: `✓ dashboard-export.json written`  
Then print the absolute file path.  
Then print a one-line summary: `[name] · [N] roadmap items · [tool names or "no tools detected"]`
