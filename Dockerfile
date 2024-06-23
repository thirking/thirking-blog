FROM node:lts AS base
WORKDIR /app
# 这里仅复制 package.json 和 package-lock.json，我们确保以下的 `-deps` 步骤与源代码无关。
# 因此，如果只有源代码发生变化，将会跳过 `-deps` 步骤。
COPY package.json package-lock.json ./
FROM base AS prod-deps
RUN npm install --omit=dev
FROM base AS build-deps
RUN npm install
FROM build-deps AS build
COPY . .
RUN npm run build
FROM base AS runtime
COPY --from=prod-deps /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
ENV HOST=0.0.0.0
ENV PORT=8080
EXPOSE 80
CMD node ./dist/server/entry.mjs