page 50042 "Performance Monitoring Form"
{
    Caption = 'Performance Monitoring Form';
    PageType = Card;
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTable = "Performance Header";
    DataCaptionFields = "No.", "Start Date", "End Date";
    SourceTableView = WHERE("Document Type" = FILTER("Performance Monitoring"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("Prepared by"; Rec."Prepared by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prepared by field.', Comment = '%';
                    Editable = false;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver No. field.', Comment = '%';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Driver Name field.', Comment = '%';
                    Editable = false;
                }
               
            }

            part(MonitorPerformance; "Performance Monitoring Subform")
            {
                Caption = 'Performance';
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = field("No.");
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Performance Header"), "No." = FIELD("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    RequisitionHeader: Record "Performance Header";
                    RptPurchaseRequisition: Report "Performance Monitoring Report";
                begin
                    RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Performance Monitoring");
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                    RptPurchaseRequisition.RUNMODAL;
                end;
            }
        }
        area(Navigation)
        {
            group(Performance)
            {
                Caption = 'Performance';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Performance Monitoring"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(DocAttachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec."Document Type" := Rec."Document Type"::"Performance Monitoring";
        Rec."Prepared by" := UserId;
    end;
}