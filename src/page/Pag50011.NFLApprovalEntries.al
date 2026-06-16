page 50011 "NFL Approval Entries"
{
    Caption = 'NFL Approval Entries';
    Editable = false;
    PageType = List;
    SourceTable = "Approval Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Overdue; Overdue)
                {
                    ApplicationArea = All;
                    Caption = 'Overdue';
                    Editable = false;
                    OptionCaption = 'Yes';
                    ToolTip = 'Overdue Entry';
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field("Limit Type"; Rec."Limit Type")
                {
                    ApplicationArea = All;
                }
                field("Approval Type"; Rec."Approval Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                // field(Payee; Payee)
                // {
                // }
                // field("Payment Voucher Currency"; "Payment Voucher Currency")
                // {
                // }
                // field("Payment Voucher Details Total"; "Payment Voucher Details Total")
                // {
                // }
                // field("Payment Voucher Lines Total"; "Payment Voucher Lines Total")
                // {
                // }
                field("Sequence No."; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Code"; Rec."Approval Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Sender ID"; Rec."Sender ID")
                {
                    ApplicationArea = All;
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Available Credit Limit (LCY)"; Rec."Available Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Date-Time Sent for Approval"; Rec."Date-Time Sent for Approval")
                {
                    ApplicationArea = All;
                }
                field("Last Date-Time Modified"; Rec."Last Date-Time Modified")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By ID"; Rec."Last Modified By User ID")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                // field(Escalated; Escalated)
                // {
                // }
                // field("Escalated by"; "Escalated by")
                // {
                // }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Document)
                {
                    Caption = 'Document';
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    // trigger OnAction();
                    // var
                    //     ApprovalEntry: Record "NFL Approval Entry";
                    // begin
                    //     CurrPage.SETSELECTIONFILTER(ApprovalEntry); // MAG 20TH. NOV. 2018, Prevent users accidentally locking tables.
                    //     IF ApprovalEntry.FIND('-') THEN
                    //         Rec.ShowDocument;
                    // end;
                }
                action(Comments)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    var
                    // ApprovalComments: Page "NFL Approval Comments"; TODO:Review the comments on this page
                    // ApprovalEntry: Record "NFL Approval Entry";
                    begin
                        // ApprovalComments.Setfilters(Rec."Table ID", Rec."Document Type", Rec."Document No.", Rec."Sequence No.");
                        // ApprovalComments.SetUpLine(Rec."Table ID", Rec."Document Type", Rec."Document No.", Rec."Sequence No.");
                        // ApprovalComments.RUN;
                    end;
                }
                action("O&verdue Entries")
                {
                    Caption = 'O&verdue Entries';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.SETFILTER(Status, '%1|%2', Rec.Status::Created, Rec.Status::Open);
                        Rec.SETFILTER("Due Date", '<%1', TODAY);
                    end;
                }
                action("All Entries")
                {
                    Caption = 'All Entries';
                    Image = EntriesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        Rec.SETRANGE(Status);
                        Rec.SETRANGE("Due Date");
                    end;
                }
            }
        }
        area(processing)
        {
        }
    }

    trigger OnAfterGetRecord();
    begin
        Overdue := Overdue::" ";
    end;

    trigger OnInit();
    begin
        RejectVisible := TRUE;
        ApproveVisible := TRUE;
    end;

    trigger OnOpenPage();
    var
        Filterstring: Text[250];
    begin
        IF Usersetup.GET(USERID) THEN BEGIN
            Rec.FILTERGROUP(2);
            Filterstring := Rec.GETFILTERS;
            Rec.FILTERGROUP(0);
            IF STRLEN(Filterstring) = 0 THEN BEGIN
                Rec.FILTERGROUP(2);
                Rec.SETCURRENTKEY("Approver ID");
                IF Overdue = Overdue::Yes THEN
                    Rec.SETRANGE("Approver ID", Usersetup."User ID");
                Rec.SETRANGE(Status, Rec.Status::Open);
                Rec.FILTERGROUP(0);
            END ELSE
                Rec.SETCURRENTKEY("Table ID", Rec."Document Type", Rec."Document No.");
        END;
    end;

    var
        Usersetup: Record "User Setup";
        // ApprovalMgt: Codeunit "NFL Approvals Management";
        Text001: Label 'You can only delegate open approval entries.';
        Text002: Label '"The selected approval(s) have been delegated. "';
        Overdue: Option Yes," ";
        Text004: Label 'Approval Setup not found.';
        ApproveVisible: Boolean;
        RejectVisible: Boolean;
        Text0010: Label 'You can only escalade open approval entries.';
        Text0020: Label '"The selected approval(s) have been escaladed. "';
        NFLReqnHeader: Record "ADT Requisition Header";
    // NFLApprovalComment: Record "NFL Approval Comment Line";

    /// <summary>
    /// Description for Setfilters.
    /// </summary>
    /// <param name="TableId">Parameter of type Integer.</param>
    /// <param name="DocumentType">Parameter of type Option "Store Requisition","Purchase Requisition",Payment,"Bank Reconciliation","Store Return".</param>
    /// <param name="DocumentNo">Parameter of type Code[20].</param>
    procedure SetFilters(TableId: Integer; DocumentType: Option "Store Requisition","Purchase Requisition",Payment,"Bank Reconciliation","Store Return"; DocumentNo: Code[20]);
    begin
        IF TableId <> 0 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETCURRENTKEY("Table ID", Rec."Document Type", Rec."Document No.");
            Rec.SETRANGE("Table ID", TableId);
            Rec.SETRANGE("Document Type", DocumentType);
            IF DocumentNo <> '' THEN
                Rec.SETRANGE("Document No.", DocumentNo);
            Rec.FILTERGROUP(0);
        END;

        ApproveVisible := FALSE;
        RejectVisible := FALSE;
    end;

    /// <summary>
    /// Description for CalledFrom.
    /// </summary>
    procedure CalledFrom();
    begin
        Overdue := Overdue::" ";
    end;
}

