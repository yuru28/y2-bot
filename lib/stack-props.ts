import { StackProps as StackPropsType } from 'aws-cdk-lib';

export interface StackProps extends StackPropsType {
  readonly stage: string;
  readonly notionApiToken: string;
  readonly notionShowNotesDatabaseId: string;
}
