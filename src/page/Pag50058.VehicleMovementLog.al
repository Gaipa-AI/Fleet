page 50058 "Vehicle Movement Log"
{
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Form Header";
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Release,Home,Delegate';
    SourceTableView = where("Document Type" = const("Vehicle Movement Log"));

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
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client No. field.', Comment = '%';
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Client Name field.', Comment = '%';
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No. field.', Comment = '%';
                }
                field("Equipment Name"; Rec."Equipment Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Name field.', Comment = '%';
                }
                field("Equipment Make"; Rec."Equipment Make")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Make field.', Comment = '%';
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Equipment Type field.', Comment = '%';
                }
                field("Equipment Model"; Rec."Equipment Model")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Model field.', Comment = '%';
                }
                field("Equipment RegNo"; Rec."Equipment RegNo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment RegNo field.', Comment = '%';
                }
                field("Equipment Serial No."; Rec."Equipment Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment Serial No. field.', Comment = '%';
                }
            }
            part(Logs; "Vehicle Movement Log Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }

        area(Factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Form Header"), "No." = FIELD("No.");
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
                    RequisitionHeader: Record "Form Header";
                    RptPurchaseRequisition: Report "Vehicle Movement Log";
                begin
                    RequisitionHeader.SETRANGE("Document Type", RequisitionHeader."Document Type"::"Vehicle Movement Log");
                    RequisitionHeader.SETRANGE("No.", Rec."No.");
                    RptPurchaseRequisition.SETTABLEVIEW(RequisitionHeader);
                    RptPurchaseRequisition.RUNMODAL;
                end;
            }
            group(Request)
            {
                action("Comments")
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = filter("Vehicle Movement Log"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(DocAttach)
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

    var
        myInt: Integer;
}