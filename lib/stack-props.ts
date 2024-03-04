import { StackProps as StackPropsType } from 'aws-cdk-lib';

export interface StackProps extends StackPropsType {
  readonly stage: 'staging' | 'production';
  readonly notionApiToken: string;
  readonly notionShowNotesDatabaseId: string;
  readonly slackWebhookUrl: string;
}
