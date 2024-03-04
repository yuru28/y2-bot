#!/usr/bin/env node

import 'source-map-support/register';
import { App } from 'aws-cdk-lib';
import { CdkStack } from '../lib/cdk-stack';

import { useCapitalize } from '../lib/utils/useCapitalize';
const { capitalize } = useCapitalize();

const app = new App();

const stage = app.node.tryGetContext('stage');
const config = app.node.tryGetContext('config')[stage] || {};

// TODO:
//   本来、SSMのSecure Stringとかでやるべき。
//   CDK上でSSMのSecure Stringを参照し環境年数にセットということが出来ないため、
//   Lambda上で動くRubyのコードでSSMのget_parameterを使う必要アリ。
config['notionApiToken'] = process.env.NOTION_API_TOKEN;
config['slackWebhookUrl'] = process.env.SLACK_WEBHOOK_URL;

const stackName = `Y2Bot${capitalize(stage)}Stack`;

new CdkStack(app, stackName, {
  stage,
  stackName,
  ...config,
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});
