page 50021 "Fleet Management Setup"
{
    PageType = Card;
    SourceTable = "Fleet Management Setup";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Fuel Req Item Jnl Template"; Rec."Fuel Req Item Jnl Template")
                {
                    ApplicationArea = All;
                }
                field("Fuel Req Item Jnl Batch"; Rec."Fuel Req Item Jnl Batch")
                {
                    ApplicationArea = All;
                }
                field("Spare Req Item Jnl Template"; Rec."Spare Req Item Jnl Template")
                {
                    ApplicationArea = All;
                }
                field("Spare Req Item Jnl Batch"; Rec."Spare Req Item Jnl Batch")
                {
                    ApplicationArea = All;
                }
                field("Gen Req Item Jnl Template"; Rec."Gen Req Item Jnl Template")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen Req Item Jnl Template field.', Comment = '%';
                }
                field("Gen Req Item Jnl Batch"; Rec."Gen Req Item Jnl Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Gen Req Item Jnl Batch field.', Comment = '%';
                }
                field("Store Req Item Jnl Template"; Rec."Store Req Item Jnl Template")
                {
                    ToolTip = 'Specifies the value of the Store Req Item Jnl Template field.', Comment = '%';
                }
                field("Store Req Item Jnl Batch"; Rec."Store Req Item Jnl Batch")
                {
                    ToolTip = 'Specifies the value of the Store Req Item Jnl Batch field.', Comment = '%';
                }
                field("Store Req. Validity Period"; Rec."Store Req. Validity Period")
                {
                    ToolTip = 'Specifies the value of the Store Req. Validity Period field.', Comment = '%';
                }
                field("Archive Purch. Requisition"; Rec."Archive Purch. Requisition")
                {
                    ToolTip = 'Specifies the value of the Archive Purch. Requisition field.', Comment = '%';
                }
                field("Archive Store Requisition"; Rec."Archive Store Requisition")
                {
                    ToolTip = 'Specifies the value of the Archive Store Requisition field.', Comment = '%';
                }
                field("Send Expiry Notification"; Rec."Send Expiry Notification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Send Expiry Notification field.', Comment = '%';
                }
                field("Expiry Warning"; Rec."Expiry Warning")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiry Warning field.', Comment = '%';
                }
                field("Send Service Notification"; Rec."Send Service Notification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Send Service Notification field.', Comment = '%';
                }
            }
            group(Numbers)
            {
                field("Fuel Requisition Nos"; Rec."Fuel Requisition Nos")
                {
                    ApplicationArea = All;
                }
                field("Spare Part Requisition Nos"; Rec."Spare Part Requisition Nos")
                {
                    ApplicationArea = All;
                }
                field("General Requisitions No."; Rec."General Requisitions No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the General Requisitions No. field.', Comment = '%';
                }
                field("Maintenance Request No."; Rec."Maintenance Request No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maintenance Request No. field.', Comment = '%';
                }
                field("Job Card No."; Rec."Job Card No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job Card No. field.', Comment = '%';
                }
                field("Assignment No."; Rec."Assignment No.")
                {
                    ToolTip = 'Specifies the value of the Fuel Requisition Archive No. Series field.', Comment = '%';
                }
                field("Performance No."; Rec."Performance No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Performance No. field.', Comment = '%';
                }
                field("Internal Hire Nos."; Rec."Internal Hire Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Internal Hire Nos. field.', Comment = '%';
                }
                field("External Hire Nos."; Rec."External Hire Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Hire Nos. field.', Comment = '%';
                }
                field("Daily Assignment Nos."; Rec."Daily Assignment Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Daily Assignment Nos. field.', Comment = '%';
                }
                field("Incident Nos."; Rec."Incident Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Incident Nos. field.', Comment = '%';
                }
                field("Vehicle Movement Log Nos."; Rec."Vehicle Movement Log Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle Movement Log Nos. field.', Comment = '%';
                }
                field("Inspection Nos"; Rec."Inspection Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inspection Nos field.', Comment = '%';
                }
                field("Journey Management Nos."; Rec."Journey Management Nos.")
                {
                    ApplicationArea = All;
                }
                field("Routine Service Tracker No."; Rec."Routine Service Tracker No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Routine Service Tracker No. field.', Comment = '%';
                }
                field("Purchase Requisition Nos"; Rec."Purchase Requisition Nos")
                {
                    ToolTip = 'Specifies the value of the Purchase Requisition Nos. field.', Comment = '%';
                }
                field("Store Requisition Nos"; Rec."Store Requisition Nos")
                {
                    ToolTip = 'Specifies the value of the Store Requisition Nos field.', Comment = '%';
                }
                field("Store Req. Archive No. Series"; Rec."Store Req. Archive No. Series")
                {
                    ToolTip = 'Specifies the value of the Store Req. Archive No. Series field.', Comment = '%';
                }
                field("Store Return Archive No series"; Rec."Store Return Archive No series")
                {
                    ToolTip = 'Specifies the value of the Store Return Archive No series field.', Comment = '%';
                }
                field("Complaint No."; Rec."Complaint No.")
                {
                    ToolTip = 'Specifies the value of the Complaint No. field.', Comment = '%';  

                }
                field("Cash Purchase Nos.";Rec."Cash Purchase Nos")
                {
                    ToolTip = 'Specifies the value of the Cash Purchase No. field.', Comment = '%';

                }
                field("Template Nos";Rec."Template Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Template Nos for the equipment template page';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}